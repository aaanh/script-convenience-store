echo -e "Automated OOBE script for macOS Monterey and up."
echo -e "Anh Hoang Nguyen (c) 2024. GPLv3."
echo -e "AnhNguyen@aaanh.com"
echo -e "----------------------------"

echo -e "YOU MIGHT BE PROMPTED FOR SUPERUSER PASSWORD."
read -p "Press ENTER to continue..."

defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock autohide -int 1
killall Dock

defaults write com.apple.finder AppleShowAllFiles -string YES
defaults -currentHost write -globalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1

/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo -e "Running: Install hombrew"
read -t 3
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo -e "Running: Install oh-my-zsh"
read -t 3
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/robbyrussell/apple/g' ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

echo -e "Running: Install Visual Studio Code"
read -t 3
curl -L "https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal" -o ~/Downloads/vscode.zip
unzip ~/Downloads/vscode.zip
mv "~/Downloads/Visual\ Studio\ Code.app" /Applications/
echo export PATH="'$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin'" >> ~/.zshrc
rm ~/Downloads/vscode.zip