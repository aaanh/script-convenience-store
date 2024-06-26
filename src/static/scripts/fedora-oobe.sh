#!/usr/bin/bash

echo -e "*******************************************************************"
echo -e "* Rudimentary automated setup script for Fedora/RHEL/CentOS Linux.*"
echo -e "* Anh Hoang Nguyen (c) 2024. MIT.                                 *"
echo -e "* AnhNguyen@aaanh.com                                             *"
echo -e "*******************************************************************"

echo -e "Now loading script..."
read -t 3

echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
read -p "Press ENTER to continue..."

echo -e "Running: dnf update"
read -t 3
sudo dnf -y update

echo -e "Running: Install commonly-used packages from dnf."
read -t 3
sudo dnf install -y zsh wget curl git neovim tmux

echo -e "Running: Changing default shell to zsh, install oh-my-zsh and additional configurations."
read -t 3

sudo usermod -s /usr/bin/zsh "$(whoami)"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
sed -i 's/robbyrussell/flazz/g' ~/.zshrc

echo -e "Setup script completed successfully."
exit 0