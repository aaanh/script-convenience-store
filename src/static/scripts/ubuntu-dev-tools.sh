#!/usr/bin/bash

echo -e "Opinionated Development Tools Install and Setup Script."
echo -e "WARNING: WILL INSTALL PROPRIETARY SOFTWARE."
echo -e "Anh Hoang Nguyen (c) 2023. GPLv3."
echo -e "iam@hoanganh.dev"
echo -e "----------------------------"

echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
read -p "Press ENTER to continue..."



echo -e "Setting script to run non-interactively."
read -t 3
export DEBIAN_FRONTEND=noninteractive

echo -e "Running: apt update and upgrade"
read -t 3
sudo apt update && sudo apt upgrade -y

echo -e "Running: Install Visual Studio Code"
read -t 3
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

echo -e "Installing: Github CLI (gh)."
read -t 3
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

echo -e "Installing: nvm, nodejs, npm, yarn"
read -t 3
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
echo -e 'export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
' >> ~/.zshrc
echo -e 'export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
' >> ~/.bashrc
source ~/.zshrc

nvm install v19
nvm use v19

echo -e "Installing: Rust via rustup"
read -t 3
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

echo -e "Installing: Golang"
read -t 3
LATEST_GO_VERSION="$(curl --silent https://go.dev/VERSION?m=text)";
LATEST_GO_DOWNLOAD_URL="https://golang.org/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz "
cd "/home/$USER" && \
    curl -OJ -L --progress-bar https://golang.org/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz
tar -xf ${LATEST_GO_VERSION}.linux-amd64.tar.gz
export GOROOT="/home/$USER/go"
export GOPATH="/home/$USER/go/packages"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
echo 'export GOROOT="/home/$USER/go"\n
export GOPATH="/home/$USER/go/packages"\n
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.bashrc
echo 'export GOROOT="/home/$USER/go"\nexport GOPATH="/home/$USER/go/packages"\nexport PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.zshrc


source ~/.zshrc


echo -e "Setup script completed successfully."
exit 0