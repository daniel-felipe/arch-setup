#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

APP_PATH=~/.local/share/applications
[ ! -d "$APP_PATH" ] && mkdir "$APP_PATH"

echo "${green}[+] Updaing System${reset}"
sudo pacman-mirrors -f && sudo pacman -Syyu --noconfirm

echo "${green}[+] Installing Packages${reset}"
[ ! -f arch.txt ] && wget https://raw.githubusercontent.com/daniel-felipe/my-dotfiles/main/packages/arch.txt -q
sudo pacman -S - < arch.txt --needed
rm arch.txt

code --version &> /dev/null
if [ $? -ne 0 ]; then
    echo "${green}[+] Installing Visual Studio Code${reset}"
    wget https://az764295.vo.msecnd.net/stable/252e5463d60e63238250799aef7375787f68b4ee/code-stable-x64-1683145858.tar.gz -O vscode.tar.gz -q
    wget https://gist.githubusercontent.com/infosec-intern/542d39e16f46ff472803a42bc50f3b4f/raw/a8c897aaede8eea51b8447f119cef07e41b576e2/vscode.desktop -q
    sudo tar -C /usr/local -xzf vscode.tar.gz 
    mv vscode.desktop ~/.local/share/applications
    rm -rf vscode.tar.gz VSCode-linux-x64
fi

subfinder --version &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${green}[+] Installing SUBFINDER \033${reset}"
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    subfinder --version &> /dev/null
fi

httpx --version &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${green}[+] Installing HTTPX \033${reset}"
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    httpx --version &> /dev/null
fi

naabu --version &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${green}[+] Installing NAABU \033${reset}"
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
    naabu --version &> /dev/null
fi

notify --version &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${green}[+] Installing NOTIFY \033${reset}"
    go install -v github.com/projectdiscovery/notify/cmd/notify@latest
    notify --version &> /dev/null
fi

nuclei --version &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${green}[+] Installing NUCLEI \033${reset}"
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    nuclei --version &> /dev/null
fi

interactsh-client --version &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${green}[+] Installing INTERACT.SH \033${reset}"
    go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest
    nuclei --version &> /dev/null
fi

echo -e "${green}[+] Installing SPOTIFY-DL"
pip install spofify_dl

starship --version &> /dev/null
if [ $? -ne 0 ]; then
    echo "${green} Installing Starship${reset}"
    curl -sS https://starship.rs/install.sh | sh
fi

zsh --version &> /dev/null
if [ $? -ne 0 ]; then
    echo "${green}[+] Istalling Oh My Zsh${reset}"
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi
