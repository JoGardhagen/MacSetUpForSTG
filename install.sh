#!/bin/bash
#To Run chmod +x install.sh
#./install.sh

#Kontrollerar Xcode Cli
if ! xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools saknas. Installerar..."
    xcode-select --install
else
    echo "Xcode Command Line Tools är redan installerat."
fi

#Kontrollerar Clang++
if clang++ --version &>/dev/null; then
    echo "Clang++ är installerat och fungerar!"
else
    echo "Clang++ kunde inte hittas. Kontrollera installationen av Xcode Command Line Tools."
fi

# Kontrollera om Homebrew är installerat
if ! command -v brew &> /dev/null
then
    echo "Homebrew är inte installerat. Installerar..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew är redan installerat!"
fi

# Kontrollera om Homebrew är i PATH
if ! grep -q "/opt/homebrew/bin" ~/.zprofile
then
    echo "Homebrew finns inte i PATH, lägger till det..."
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
    echo "Homebrew har lagts till i din PATH."
else
    echo "Homebrew finns redan i din PATH."
fi

# Ladda om .zprofile och .zshrc för att ändringarna ska träda i kraft
source ~/.zprofile
source ~/.zshrc

# Kontrollera om CMake är installerat
if ! command -v cmake &> /dev/null; then
    echo "CMake är inte installerat. Installerar..."
    brew install cmake
else
    echo "CMake är redan installerat!"
fi

# Kontrollera om VSCode är installerat
if ! command -v code &> /dev/null
then
    echo "Visual Studio Code är inte installerat. Installerar..."
    brew install --cask visual-studio-code
else
    echo "Visual Studio Code är redan installerat!"
fi

# Kontrollera om VS Code C++ Extension Pack redan är installerat
if code --list-extensions | grep -q "ms-vscode.cpptools-extension-pack"; then
    echo "C++ Extension Pack är redan installerat!"
else
    echo "Installerar VS Code C++ Extension Pack..."
    code --install-extension ms-vscode.cpptools-extension-pack
    echo "VS Code C++ Extension Pack har installerats!"
fi

echo "Alla verktyg är nu installerade och klara!"