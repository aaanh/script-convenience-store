#!/usr/bin/bash

echo -e "Rudimentary automated setup script for Arch-based Linux distros."
echo -e "Anh Hoang Nguyen (c) 2024. GPLv3."
echo -e "AnhNguyen@aaanh.com"
echo -e "----------------------------"

echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
read -p "Press ENTER to continue..."

echo -e "Update pacman listing and upgrade system"

sudo pacman -Syyu

echo -e "Install dependencies for AUR"

sudo pacman -Sy base-devel git

echo -e "Install commonly-used packages from pacman"

sudo pacman -Sy ttf-fira-code ibus-unikey zsh discord

echo -e "Clone and install packages from AUR"

cd ~/Downloads

git clone https://aur.archlinux.org/google-chrome.git && makepkg -sri ./google-chrome/
git clone https://aur.archlinux.org/visual-studio-code-bin.git && makepkg -sri ./visual-studio-code-bin/

echo -e "All tasks completed."
read -p "Press ENTER to return to shell."
