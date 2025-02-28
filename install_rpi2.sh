#!/bin/bash

# Uppdatera paketlistan
echo "Uppdaterar paketlistan..."
sudo apt update && sudo apt upgrade -y

install_if_missing(){
    if ! command -v "$1" &> /dev/null; then
        echo "Installerar $1..."
        sudo apt install -y "$2"
    else
        echo "$2 är redan installerat!"
    fi
}

install_if_missing clang clang
install_if_missing cmake cmake

echo "Installerar nödvändiga paket för Raylib..."
sudo apt install -y libasound2-dev libx11-dev libxrandr-dev libxinerama-dev \
                     libxcursor-dev libxi-dev libgl1-mesa-dev

export KEYRING_PATH=/etc/apt/keyrings/package.microsoft.gpg
export LIST_PATH=/etc/apt/sources.list.d/vscode.list
export BASE_URL=https://packages.microsoft.com

if [ ! -f "$KEYRING_PATH" ]; then
    echo "Downloading MS key..."
    wget -qO- $BASE_URL/keys/microsoft.asc | gpg --dearmor | sudo tee $KEYRING_PATH > /dev/null
    echo "Adding Microsoft repo for VS Code..."
    echo "deb [arch=arm64 signed-by=$KEYRING_PATH] $BASE_URL/repos/code stable main" | sudo tee $LIST_PATH > /dev/null
    sudo apt update
fi

# Kolla om VS Code är installerat, annars installera det
if ! command -v code &> /dev/null; then
    echo "Installerar VS Code..."
    sudo apt install -y code
else
    echo "VS Code är redan installerat!"
fi

# Kolla om VS Code C++ Extension Pack är installerat
if ! code --list-extensions | grep -q "ms-vscode.cpptools-extension-pack"; then
    echo "Installerar VS Code C++ Extension Pack..."
    code --install-extension ms-vscode.cpptools-extension-pack
else
    echo "VS Code C++ tillägg är redan installerade!"
fi

echo "Installationen klar!"
