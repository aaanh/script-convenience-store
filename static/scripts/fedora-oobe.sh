#!/usr/bin/bash

echo -e "*******************************************************************"
echo -e "* Rudimentary automated setup script for Fedora/RHEL/CentOS Linux.*"
echo -e "* Anh Hoang Nguyen (c) 2024. GPLv3.                               *"
echo -e "* AnhNguyen@aaanh.com                                             *"
echo -e "*******************************************************************"

echo -e "Now loading script..."
read -t 5

echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
read -p "Press ENTER to continue..."

echo -e "Running: dnf update"
read -t 3
sudo dnf -y update

echo -e "Running: Install commonly-used packages from dnf."
read -t 3
sudo dnf install -y zsh wget curl

echo -e "Running: Install neovim from yum"
read -t 3
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo yum install -y neovim python3-neovim
echo 'export alias vim=nvim' >> ~/.zshrc

echo -e "Powering up nvim using NvChad"
read -t 3
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

echo -e "Running: Changing default shell to zsh and additional configurations."
read -t 3

sudo usermod -s /usr/bin/zsh "$(whoami)"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
sed -i 's/robbyrussell/flazz/g' ~/.zshrc

echo -e "Setup script completed successfully."
exit 0