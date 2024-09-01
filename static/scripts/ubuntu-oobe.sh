#!/usr/bin/bash

echo -e "*********************************************************************"
echo -e "* Rudimentary automated setup script for Debian-based Linux distros *"
echo -e "* Anh Hoang Nguyen (c) 2024. MIT.                                   *"
echo -e "* AnhNguyen@aaanh.com                                               *"
echo -e "*********************************************************************"

echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
read -p "Press ENTER to continue..."



echo -e "Setting script to run non-interactively."
read -t 3
export DEBIAN_FRONTEND=noninteractive

echo -e "Running: apt update and upgrade"
read -t 3
sudo apt update && sudo apt upgrade -y

echo -e "Running: Install commonly-used packages from apt."
read -t 3
sudo apt install -y git zsh net-tools build-essential vim openssh-server \
    tmux curl

echo -e "Running: Changing default shell to zsh and additional configurations."
read -t 3
chsh -s /bin/zsh && \
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1 && \
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc" && \
sed -i 's/robbyrussell/flazz/g' ~/.zshrc

echo -e "Setup script completed successfully."
exit 0