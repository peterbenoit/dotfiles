# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
# ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k"
ZSH_THEME="powerlevel10k/powerlevel10k"

# ZSH_THEME="spaceship"

# Customize Spaceship prompt
# SPACESHIP_PROMPT_ORDER=(
#   user		  # Username section
#   dir		   # Current directory section
#   host		  # Hostname section
#   git		   # Git section (git_branch + git_status)
#   node		  # Node.js version
#   python		# Python version
#   time		  # Time stamps
#   exec_time	 # Execution time
#   line_sep	  # Line break
#   vi_mode	   # Vi-mode indicator
#   jobs		  # Background jobs indicator
#   exit_code	 # Exit code section
#   char		  # Prompt character
# )


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode auto	  # update automatically without asking

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# HIST_STAMPS="yyyy-mm-dd"

# Plugins
plugins=(git)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Set PATH to include Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Preferred editor for local and remote sessions
export EDITOR="code --wait"

# Aliases for convenience
# Navigation Shortcuts
alias ll="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"  # Quickly go to the home directory
alias c="clear"  # Clear the terminal screen
alias reload="source ~/.zshrc"


# Git Shortcuts
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gst="git status"
alias gco="git checkout"
alias gl="git log"
alias gpl="git pull"
alias gcm="git checkout main"

# NPM/Yarn Shortcuts
alias nis="npm install --save"
alias nid="npm install --save-dev"
alias nrb="npm run build"
alias nrs="npm run start"
alias yrb="yarn run build"
alias yrs="yarn run start"

# System Shortcuts
alias brewup="brew update && brew upgrade && brew cleanup"
alias brewlist="brew list --cask"
alias bcleanup="brew cleanup"
alias trash="rm -rf ~/.Trash/*"  # Empty the trash

# Code Shortcuts
alias vsc="code ."  # Open VS Code in the current directory
alias github="cd ~/Documents/GitHub"
alias editzsh="code ~/.zshrc"

# Networking
alias ip="curl ifconfig.me"  # Get your public IP address
alias myip="ifconfig | grep 'inet ' | grep -v 127.0.0.1"  # Get your local IP address

# Xcode
# Uncomment if you haven't installed Xcode tools yet
# xcode-select --install

# Homebrew Packages Installed
# You can keep this section as a reference or move it to a separate script file if you don’t need to reinstall frequently.

# Essential Command-Line Tools
# brew install wget
# brew install htop
# brew install jq
# brew install neofetch
# brew install nmap
# brew install fonttools

# Programming Languages and Libraries
# brew install python@3.12
# brew install node

# Networking and Security Tools
# brew install --cask wireshark

# Utilities
# brew install --cask alfred
# brew install --cask bitwarden
# brew install --cask bartender
# brew install --cask github

# Media
# brew install --cask vlc

# Terminal Enhancements
# brew install --cask iterm2

# Browser
# brew install --cask google-chrome

# Other Useful Tools
# brew install --cask chatgpt
# brew install --cask affinity-photo
# brew install yarn
# brew install zsh-syntax-highlighting
# brew install zsh-autosuggestions
# brew install --cask snagit

# Global Node packages
# npm install -g eslint
# npm install -g prettier
# npm install -g eslint prettier
# npm install -g eslint-plugin-prettier eslint-config-prettier




source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
