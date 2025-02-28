# NOTE : den här är obsolete fungerar någolunda men använd install_rpi2.sh istället

#!/bin/bash

#Updatera paketlistan

echo "Uppdatera paketlistan"
sudo apt update && sudo apt upgrade -y

install_if_missing(){
    if ! command -v "$1" &> /dev/null; then
        echo "Installerar $s..."
        sudo apt install -y "$2"
    else
        echo "$2 redan installerat!"
    fi
}

install_if_missing clang++ clang   
install_if_missing cmake cmake

if ! command -v code &> /dev/null; then

    echo "Installerar VsCode..."      

    if [! -f "/usr/share/keyring/package.microsoft.gpg"]; then
        echo "Lägger till Microsoft repository för VsCode..."
        wget -qO- https://package.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
        echo "deb [arch=arm64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/ code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list> /dev/null
        sudo apt update
    fi
        sudo apt install -y code

else
    echo "VsCode är redan installerat!"
fi

 

if ! code --list-extensions | grep -q "ms-vscode.cpptools-extension-pack"; then
    echo "Installerar VsCode C++ Extension Pack..."
    sudo code --install-extension ms-vscode.cpptools-extension-pack --force --user-data-dir="$USER_HOME/.vscode-data"
else
    echo "VsCode C++ Tilläggen är redan installerade"
fi

echo " Installationen klar! "