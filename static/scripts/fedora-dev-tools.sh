#!/usr/bin/bash

echo -e "*******************************************************************"
echo -e "* Rudimentary automated setup script for Fedora/RHEL/CentOS Linux.*"
echo -e "* Anh Hoang Nguyen (c) 2023. GPLv3.                               *"
echo -e "* anhnguyen@aaanh.com                                             *"
echo -e "*******************************************************************"

echo -e "Now loading script..."
read -t 3

echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
read -p "Press ENTER to continue..."

echo -e "Installing: Development tools via dnf group"
read -t 3
sudo dnf group install -y "Development Tools"

echo -e "Installing: Rust via rustup"
read -t 3
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

echo -e "Installing: Golang"
read -t 3
sudo dnf install -y go

echo -e "Installing: nvm, nodejs, npm, yarn"
read -t 3
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
nvm install 20
nvm use 20
npm i -g yarn

echo -e "Installing: Visual Studio Code by Microsoft (tm)"
echo -e "Script provided by Microsoft. See https://code.visualstudio.com/docs/setup/linux"
read -t 3
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install -y code

echo -e "Setup script completed successfully."
exit 0