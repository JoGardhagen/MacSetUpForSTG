# Installationsguide

Denna guide beskriver hur du installerar och konfigurerar nödvändiga verktyg på en macOS-maskin för C++-utveckling med Homebrew och Visual Studio Code.

## Körning av installationsscriptet

För att köra installationsscriptet, gör följande:

```sh
chmod +x install.sh
./install.sh
```
Det kan komma en popup som säger du är påväg o installera CLI för Xcode svara ja på den-

## När scriptet har tuggat klart 

stäng terminalen och öppna en ny skriv
```sh
brew --version
code --version
```

## Vad scriptet gör
```sh

1. Kontroll av Xcode Command Line Tools

Scriptet verifierar om Xcode Command Line Tools är installerat. Om det saknas installeras det automatiskt.

2. Kontroll av Clang++

Kontrollerar om Clang++ är installerat och fungerar korrekt. Om det saknas visas en varning.

3. Installation av Homebrew

Om Homebrew inte finns installerat hämtas och installeras det.

4. Uppdatering av PATH för Homebrew

Om Homebrew inte finns i systemets PATH läggs det till genom att uppdatera ~/.zprofile och ~/.zshrc.

5. Installation av CMake

Kontrollerar om CMake finns installerat, annars installeras det via Homebrew.

6. Installation av Visual Studio Code

Om Visual Studio Code inte finns installerat hämtas och installeras det via Homebrew Cask.

7. Installation av C++ Extension Pack för VS Code

Om VS Code C++ Extension Pack saknas installeras det automatiskt.

```