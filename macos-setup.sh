#!/bin/bash

# Color codes for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default options
INTERACTIVE=false
SKIP_UI=false
SKIP_KEYBOARD=false
SKIP_FINDER=false
SKIP_DOCK=false
SKIP_SAFARI=false
SKIP_TERMINAL=false
SKIP_DEV=false

# Process command line arguments
for arg in "$@"; do
  case $arg in
    --interactive)
      INTERACTIVE=true
      ;;
    --skip-ui)
      SKIP_UI=true
      ;;
    --skip-keyboard)
      SKIP_KEYBOARD=true
      ;;
    --skip-finder)
      SKIP_FINDER=true
      ;;
    --skip-dock)
      SKIP_DOCK=true
      ;;
    --skip-safari)
      SKIP_SAFARI=true
      ;;
    --skip-terminal)
      SKIP_TERMINAL=true
      ;;
    --skip-dev)
      SKIP_DEV=true
      ;;
    --help)
      echo "Usage: ./macos-setup.sh [options]"
      echo "Options:"
      echo "  --interactive     Ask before applying each section"
      echo "  --skip-ui         Skip UI/UX settings"
      echo "  --skip-keyboard   Skip keyboard and input settings"
      echo "  --skip-finder     Skip Finder settings"
      echo "  --skip-dock       Skip Dock settings"
      echo "  --skip-safari     Skip Safari settings"
      echo "  --skip-terminal   Skip Terminal settings"
      echo "  --skip-dev        Skip development tool settings"
      echo "  --help            Show this help message"
      exit 0
      ;;
  esac
done

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}   macOS Setup for Front-End Developers ${NC}"
echo -e "${BLUE}========================================${NC}"

# Display warning about system changes
echo -e "${YELLOW}WARNING: This script modifies macOS system settings."
echo -e "It's recommended to review the changes before proceeding.${NC}"
echo
echo -e "Interactive mode: ${INTERACTIVE}"
echo

# Continue prompt function
continue_prompt() {
  local section=$1

  if $INTERACTIVE; then
    read -p "$(echo -e $YELLOW"Apply $section settings? [y/n] "$NC)" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo -e "${BLUE}Skipping $section settings.${NC}"
      return 1
    fi
  fi

  return 0
}

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

apply_uiux_settings() {
  if $SKIP_UI; then
    echo -e "${BLUE}Skipping UI/UX settings (--skip-ui flag used).${NC}"
    return
  fi

  if ! continue_prompt "UI/UX"; then
    return
  fi

  echo -e "${YELLOW}Configuring general UI/UX settings...${NC}"

  # Set computer name
  read -p "Enter computer name (leave blank to skip): " COMPUTER_NAME
  if [ -n "$COMPUTER_NAME" ]; then
    sudo scutil --set ComputerName "$COMPUTER_NAME"
    sudo scutil --set HostName "$COMPUTER_NAME"
    sudo scutil --set LocalHostName "$COMPUTER_NAME"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"
  fi

  # Expand save panel by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  # Expand print panel by default
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  # Save to disk (not to iCloud) by default
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  # Disable automatic capitalization
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  # Disable auto-correct
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  echo -e "${GREEN}UI/UX settings applied.${NC}"
}

###############################################################################
# Trackpad, mouse, keyboard, and input                                        #
###############################################################################

apply_input_settings() {
  if $SKIP_KEYBOARD; then
    echo -e "${BLUE}Skipping keyboard and input settings (--skip-keyboard flag used).${NC}"
    return
  fi

  if ! continue_prompt "keyboard and input"; then
    return
  fi

  echo -e "${YELLOW}Configuring input device settings...${NC}"

  # Enable full keyboard access for all controls
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  # Use scroll gesture with the Ctrl (^) modifier key to zoom
  defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
  defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

  # Ask before setting keyboard speed
  if $INTERACTIVE; then
    read -p "$(echo -e $YELLOW"Set faster keyboard repeat rate? (This makes keys repeat faster when held down) [y/n] "$NC)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      # Set a blazingly fast keyboard repeat rate
      defaults write NSGlobalDomain KeyRepeat -int 2
      defaults write NSGlobalDomain InitialKeyRepeat -int 15
      echo -e "${GREEN}Keyboard repeat rate increased.${NC}"
    fi
  else
    # Set a moderate keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 6
    defaults write NSGlobalDomain InitialKeyRepeat -int 25
  fi

  echo -e "${GREEN}Keyboard and input settings applied.${NC}"
}

###############################################################################
# Finder                                                                      #
###############################################################################

apply_finder_settings() {
  if $SKIP_FINDER; then
    echo -e "${BLUE}Skipping Finder settings (--skip-finder flag used).${NC}"
    return
  fi

  if ! continue_prompt "Finder"; then
    return
  fi

  echo -e "${YELLOW}Configuring Finder settings...${NC}"

  # Show hidden files
  if $INTERACTIVE; then
    read -p "$(echo -e $YELLOW"Show hidden files in Finder? [y/n] "$NC)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      defaults write com.apple.finder AppleShowAllFiles -bool true
    fi
  else
    defaults write com.apple.finder AppleShowAllFiles -bool true
  fi

  # Show all filename extensions
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Show status bar
  defaults write com.apple.finder ShowStatusBar -bool true

  # Show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # Keep folders on top when sorting by name
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  # When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Disable the warning when changing a file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Avoid creating .DS_Store files on network or USB volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  echo -e "${GREEN}Finder settings applied.${NC}"
}

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

apply_dock_settings() {
  if $SKIP_DOCK; then
    echo -e "${BLUE}Skipping Dock settings (--skip-dock flag used).${NC}"
    return
  fi

  if ! continue_prompt "Dock"; then
    return
  fi

  echo -e "${YELLOW}Configuring Dock settings...${NC}"

  # Set the icon size of Dock items
  defaults write com.apple.dock tilesize -int 48

  # Minimize windows into their application's icon
  defaults write com.apple.dock minimize-to-application -bool true

  # Show indicator lights for open applications in the Dock
  defaults write com.apple.dock show-process-indicators -bool true

  # Ask about auto-hide
  if $INTERACTIVE; then
    read -p "$(echo -e $YELLOW"Automatically hide and show the Dock? [y/n] "$NC)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      defaults write com.apple.dock autohide -bool true
    fi
  else
    # Don't change by default
    echo "Leaving Dock autohide setting unchanged"
  fi

  echo -e "${GREEN}Dock settings applied.${NC}"
}

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

apply_safari_settings() {
  if $SKIP_SAFARI; then
    echo -e "${BLUE}Skipping Safari settings (--skip-safari flag used).${NC}"
    return
  fi

  if ! continue_prompt "Safari"; then
    return
  fi

  echo -e "${YELLOW}Configuring Safari settings...${NC}"

  # Show the full URL in the address bar
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

  # Prevent Safari from opening 'safe' files automatically after downloading
  defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

  # Enable the Develop menu and the Web Inspector in Safari
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabled -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

  # Enable "Do Not Track"
  defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

  echo -e "${GREEN}Safari settings applied.${NC}"
}

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

apply_terminal_settings() {
  if $SKIP_TERMINAL; then
    echo -e "${BLUE}Skipping Terminal settings (--skip-terminal flag used).${NC}"
    return
  fi

  if ! continue_prompt "Terminal"; then
    return
  fi

  echo -e "${YELLOW}Configuring Terminal and iTerm2 settings...${NC}"

  # Only use UTF-8 in Terminal.app
  defaults write com.apple.terminal StringEncodings -array 4

  # Enable Secure Keyboard Entry in Terminal.app
  defaults write com.apple.terminal SecureKeyboardEntry -bool true

  # Ask about installing Oh My Zsh
  if [ ! -d "$HOME/.oh-my-zsh" ] && $INTERACTIVE; then
    read -p "$(echo -e $YELLOW"Install Oh My Zsh? [y/n] "$NC)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo -e "${GREEN}Installing Oh My Zsh...${NC}"
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
  elif [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Skipping Oh My Zsh installation"
  else
    echo "Oh My Zsh is already installed."
  fi

  echo -e "${GREEN}Terminal settings applied.${NC}"
}

###############################################################################
# Development settings                                                        #
###############################################################################

apply_dev_settings() {
  if $SKIP_DEV; then
    echo -e "${BLUE}Skipping development settings (--skip-dev flag used).${NC}"
    return
  fi

  if ! continue_prompt "development"; then
    return
  fi

  echo -e "${YELLOW}Configuring development settings...${NC}"

  # Configure Git if installed
  if command -v git &> /dev/null; then
    echo -e "${YELLOW}Git is installed. Would you like to configure it?${NC}"
    read -p "$(echo -e $YELLOW"Configure Git? [y/n] "$NC)" -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
      # Ask for user info
      read -p "Enter your Git username: " GIT_USERNAME
      read -p "Enter your Git email: " GIT_EMAIL

      # Set Git configuration
      git config --global user.name "$GIT_USERNAME"
      git config --global user.email "$GIT_EMAIL"

      # Set common Git configuration
      git config --global init.defaultBranch main
      git config --global core.editor "code --wait"
      git config --global pull.rebase true

      echo -e "${GREEN}Git configured.${NC}"
    fi
  fi

  echo -e "${GREEN}Development settings applied.${NC}"
}

###############################################################################
# Apply settings                                                              #
###############################################################################

apply_uiux_settings
apply_input_settings
apply_finder_settings
apply_dock_settings
apply_safari_settings
apply_terminal_settings
apply_dev_settings

###############################################################################
# Finalize changes                                                            #
###############################################################################

echo -e "${YELLOW}Do you want to restart affected applications to apply changes?${NC}"
read -p "$(echo -e $YELLOW"Restart applications? [y/n] "$NC)" -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${YELLOW}Restarting affected applications...${NC}"
  for app in "Finder" "Dock" "Safari" "Terminal"; do
    killall "${app}" &> /dev/null
  done
fi

echo -e "${GREEN}macOS setup complete!${NC}"
echo -e "${YELLOW}Note: Some changes may require a logout/restart to take effect.${NC}"
