#include <iostream>
#include "httplib.h"
#include <cstdlib>
#include <cstdio>
#include <string>
#include <sstream>
#include <fstream>

std::string exec(const char* cmd) {
    char buffer[128];
    std::string result = "";
    FILE* fp = popen(cmd, "r");
    if (fp == nullptr) {
        perror("popen failed");
        return result;
    }
    while (fgets(buffer, sizeof(buffer), fp) != nullptr) {
        result += buffer;
    }
    fclose(fp);
    return result;
}

int main() {
    httplib::Server svr;

    svr.Get("/get_ip", [](const httplib::Request& req, httplib::Response& res) {
        std::string ip = exec("hostname -I");
        res.set_content(ip, "text/plain");
    });

    svr.Get("/get_uptime", [](const httplib::Request& req, httplib::Response& res) {
        std::string uptime = exec("uptime -p");
        res.set_content(uptime, "text/plain");
    });

    svr.Get("/get_disk", [](const httplib::Request& req, httplib::Response& res) {
        std::string disk = exec("df -h");
        res.set_content(disk, "text/plain");
    });

    svr.Get("/", [](const httplib::Request& req, httplib::Response& res) {
        std::ifstream file("index.html");//byt denna till indexWithStyle.html
        if (file.is_open()) {
            std::stringstream buffer;
            buffer << file.rdbuf();
            res.set_content(buffer.str(), "text/html");
        } else {
            res.status = 404;
            res.set_content("404 Not Found", "text/plain");
        }
    });
    std::cout << "[INFO] Server is running on http://localhost:8080\n";
    svr.listen("0.0.0.0", 8080);

    return 0;
}
