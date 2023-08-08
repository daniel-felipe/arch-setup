#!/bin/bash

ROOT=$(cd $(dirname "$BASH_SOURCE[0]") && pwd)

# colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

# applications path
APP_PATH="$HOME/.local/share/applications"
[ ! -d "$APP_PATH" ] && mkdir "$APP_PATH"

# updating
echo "[${green}+${reset}] Updating System"
sudo pacman -Syyu --noconfirm

# tools
echo "[${green}+${reset}] Installing Packages"
[ ! -f arch.txt ] && wget https://raw.githubusercontent.com/daniel-felipe/my-dotfiles/main/config/packages/arch.txt -q
sudo pacman -S $(cat arch.txt) --needed
rm arch.txt

code --version &> /dev/null
if [ $? -ne 0 ]; then
    echo "[${green}+${reset}] Installing Visual Studio Code"
    wget https://az764295.vo.msecnd.net/stable/252e5463d60e63238250799aef7375787f68b4ee/code-stable-x64-1683145858.tar.gz -O vscode.tar.gz -q
    wget https://gist.githubusercontent.com/infosec-intern/542d39e16f46ff472803a42bc50f3b4f/raw/a8c897aaede8eea51b8447f119cef07e41b576e2/vscode.desktop -q
    sudo tar -C /usr/local -xzf vscode.tar.gz 
    mv vscode.desktop ~/.local/share/applications
    rm -rf vscode.tar.gz VSCode-linux-x64
fi

pdtm --version &> /dev/null
if [ $? -ne 0 ]; then
    echo "[${green}+${reset}] Installing PDTM"
    go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest
fi

amass --version
if [ $? -ne 0 ]; then
    echo "[${green}+${reset}] Installing Amass"
    go install -v github.com/owasp-amass/amass/v3/...@master
fi

massdns --version
if [ $? -ne 0 ]; then
    echo "[${green}+${reset}] Installing Shuffledns"
    git clone https://github.com/blechschmidt/massdns.git
    cd massdns && make && sudo cp bin/massdns /usr/local/bin/massdns
    cd $ROOT
fi

zap
if [ $? -ne 0 ]; then
    echo "[${green}+${reset}] Installing Zsh Zap"
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
fi

echo "[${green}+${reset}] Installing LocalSend"
yay -S localsend-bin
