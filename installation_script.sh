#!/bin/zsh

# Check if Homebrew is installed, and install it if not
if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# List of applications to install using Homebrew
apps_to_install=(
  git
  gh
  nvm
  python
  typescript
  volta
  aws-cdk
  awscli
  visual-studio-code
  slack
  discord
  amazon-chime
  sublime-text
  authy
  thefuck
  postman
  docker
  whatsapp
)

# Iterate through the list and install each application
for app in "${apps_to_install[@]}"; do
  if ! command -v "$app" &> /dev/null; then
    echo "Installing $app..."
    brew install "$app"
  else
    echo "$app is already installed."
  fi
done

# Set macOS to show file extensions
echo "Setting macOS to show file extensions..."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
killall Finder

# Configure mouse settings
echo "Configuring mouse settings..."
# Disable Natural Scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# Enable "Click Right Side" for secondary click
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton
# Enable one-finger swipe between pages (if applicable)
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true

# Enable Dark Mode
echo "Enabling Dark Mode..."
defaults write NSGlobalDomain AppleInterfaceStyle Dark

echo "Configuring terminal UI..."
echo "#Configure Terminal UI" >> ~/.zshrc
echo 'parse_git_branch() { ' >> ~/.zshrc
echo "    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'" >> ~/.zshrc
echo "}" >> ~/.zshrc
echo "COLOR_DEF='%f'" >> ~/.zshrc
echo "COLOR_USR='%F{243}'" >> ~/.zshrc
echo "COLOR_DIR='%F{197}'" >> ~/.zshrc
echo "COLOR_GIT='%F{39}'" >> ~/.zshrc
echo "# About the prefixed `$`: https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_03.html#:~:text=Words%20in%20the%20form%20%22%24',by%20the%20ANSI%2DC%20standard." >> ~/.zshrc
echo "NEWLINE=$'\n'" >> ~/.zshrc
echo "# Set zsh option for prompt substitution" >> ~/.zshrc
echo "setopt PROMPT_SUBST" >> ~/.zshrc
echo "export PROMPT='${COLOR_USR}%n@%M ${COLOR_DIR}%d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE}%% '" >> ~/.zshrc

echo '' >> ~/.zshrc
echo "Configuring terminal history behaviour..."
echo "#start of history autocomplete" >> ~/.zshrc
echo "# Original setup guide for history: https://devpress.csdn.net/linux/62ebc10e89d9027116a0f763.html" >> ~/.zshrc
echo "# initialize autocompletion" >> ~/.zshrc
echo "autoload -U compinit && compinit" >> ~/.zshrc

echo '' >> ~/.zshrc
echo "# history setup" >> ~/.zshrc
echo "setopt SHARE_HISTORY" >> ~/.zshrc
echo "HISTFILE=$HOME/.zhistory" >> ~/.zshrc
echo "SAVEHIST=1000000" >> ~/.zshrc
echo "HISTSIZE=1000000" >> ~/.zshrc

echo '' >> ~/.zshrc
echo "# The meaning of these options can be found in man page of `zshoptions`." >> ~/.zshrc
echo "setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list" >> ~/.zshrc
echo "setopt HIST_SAVE_NO_DUPS  # do not save duplicated command" >> ~/.zshrc
echo "setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks" >> ~/.zshrc
echo "setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution" >> ~/.zshrc
echo "setopt EXTENDED_HISTORY  # record command start time" >> ~/.zshrc
echo "setopt HIST_EXPIRE_DUPS_FIRST" >> ~/.zshrc

echo '' >> ~/.zshrc
echo "# autocompletion using arrow keys (based on history)" >> ~/.zshrc
echo "bindkey '\e[A' history-search-backward" >> ~/.zshrc
echo "bindkey '\e[B' history-search-forward" >> ~/.zshrc
echo "#end of history automcomplete" >> ~/.zshrc

echo '' >> ~/.zshrc
#Configure NVM add more dependencies
echo "Configuring NVM..."
mkdir ~/.nvm
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm' >> ~/.zshrc
echo '[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zshrc
nvm install 18
npx husky install
npm install -g artillery@latest
npm install artillery-engine-playwright

# Append 'eval $(thefuck --alias)' to .zshrc
echo "Adding the fuckery to .zshrc for thefuck command..."
echo 'eval $(thefuck --alias)' >> ~/.zshrc
echo '' >> ~/.zshrc
echo "Setting up aliases..."
echo '#Aliases' >> ~/.zshrc
echo 'alias main="git checkout main && git pull"' >> ~/.zshrc
echo 'alias pull="git pull"' >> ~/.zshrc
echo 'alias push="git push"' >> ~/.zshrc
echo 'alias fetch="git fetch"' >> ~/.zshrc
echo 'alias show="git show"' >> ~/.zshrc
echo 'alias log="git log"' >> ~/.zshrc
echo 'alias status="git status"' >> ~/.zshrc
echo 'alias stash="git stash"' >> ~/.zshrc
echo 'alias history="fc -l 1"' >> ~/.zshrc
echo 'alias zshme="open ~/.zshrc"' >> ~/.zshrc
echo 'alias uataws="export AWS_PROFILE=uat"' >> ~/.zshrc
echo 'alias prodaws="export AWS_PROFILE=prod"' >> ~/.zshrc
echo 'alias repo="cd ~/code/repo && git pull"' >> ~/.zshrc


# Restart the Finder to apply changes
killall Finder

echo "Installation complete."
