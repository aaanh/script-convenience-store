#!/bin/zsh

mkdir ~/.gnupg

echo "use-agent" >> ~/.gnupg/gpg.conf
echo -e "default-cache-ttl 34560000\nmax-cache-ttl 34560000" >> ~/.gnupg/gpg-agent.conf

brew install pinetry-mac

pinetry-prgoram /opt/homebrew/bin/pinetry-mac

echo "export GPG_TTY=$(tty)" >> ~/.zshrc
echo "gpgconf --launch gpg-agent" >> ~/.zshrc

source ~/.zshrc

gpg --full-gen-key

gpg --list-secret-keys --keyid-format SHORT

read -p "Copy your RSA key ID generated above. Then paste it here (and press Enter): " rsa_key_id

git config --global user.signingkey $rsa_key_id
git config --global commit.gpgSign true
git config --global tag.gpgSign true

read -p "Enter your email address (and press Enter): " email_address
git config --global user.email $email_address

gpg --armor --export $rsa_key_id | pbcopy

echo "Your public key has been copied to your clipboard. Now go to GitHub and to add it in (verified)."

read -t 10 -p "Opening browser..."

open https://github.com/settings/gpg/new