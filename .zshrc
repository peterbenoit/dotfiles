# ====================================================================
# PowerLevel10k Configuration
# ====================================================================
# Enable Powerlevel10k instant prompt (keep at top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ====================================================================
# Oh My Zsh Configuration
# ====================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  vscode
  npm
  yarn
  node
  macos
  brew
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# ====================================================================
# Path Configuration
# ====================================================================
# Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Python
export PATH="/opt/homebrew/opt/python@3.12/bin:$PATH"
alias python='python3'
alias pip='pip3'

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Cargo/Rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Deno
[ -f "$HOME/.deno/env" ] && source "$HOME/.deno/env"

# ====================================================================
# Editor Configuration
# ====================================================================
export EDITOR="code --wait"

# ====================================================================
# Front-End Development Aliases
# ====================================================================
# React shortcuts
alias cra="npx create-react-app"
alias crats="npx create-react-app --template typescript"
alias next="npx create-next-app"
alias nextts="npx create-next-app --typescript"
alias vite="npm create vite@latest"

# Vue shortcuts
alias vue="npm init vue@latest"

# Angular shortcuts
alias ng="npx @angular/cli"
alias ngnew="npx @angular/cli new"

# NPM shortcuts
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias nr="npm run"
alias nrs="npm run start"
alias nrd="npm run dev"
alias nrb="npm run build"
alias nrt="npm run test"
alias nrl="npm run lint"

# Yarn shortcuts
alias yi="yarn install"
alias ya="yarn add"
alias yad="yarn add --dev"
alias yr="yarn run"
alias yrs="yarn run start"
alias yrd="yarn run dev"
alias yrb="yarn run build"
alias yrt="yarn run test"
alias yrl="yarn run lint"

# Web dev shortcuts
alias serve="npx serve"
alias netlify="npx netlify-cli"
alias surge="npx surge"
alias vercel="npx vercel"
alias firebase="npx firebase-tools"

# Performance testing
alias lighthouse="npx lighthouse"
alias bundlesize="npx bundlesize"
alias sizereport="npx size-limit"

# Linting and Formatting
alias lint="npm run lint"
alias format="npm run format"
alias eslintfix="npx eslint --fix"
alias prettierfix="npx prettier --write"

# ====================================================================
# General Aliases
# ====================================================================
# Navigation
alias ll="ls -la"
alias la="ls -a"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias c="clear"

# System
alias reload="source ~/.zshrc"
alias brewup="brew update && brew upgrade && brew cleanup"
alias brewlist="brew list --cask"
alias bcleanup="brew cleanup"
alias trash="rm -rf ~/.Trash/*"
alias dotfiles="code ~/.zshrc"
alias warp="open -a Warp"  # Open Warp terminal

# Networking
alias ip="curl ifconfig.me"
alias myip="ifconfig | grep 'inet ' | grep -v 127.0.0.1"
alias ports="lsof -i -P | grep -i 'listen'"
alias localip="ipconfig getifaddr en0"

# ====================================================================
# Git Aliases
# ====================================================================
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git status"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias gm="git merge"
alias gl="git log --oneline --graph"
alias grh="git reset --hard"
alias grs="git reset --soft"
alias gf="git fetch"
alias gcl="git clone"
alias gr="git remote"
alias grv="git remote -v"

# ====================================================================
# Folder shortcuts
# ====================================================================
alias github="cd ~/GitHub"
alias projects="cd ~/Projects"
alias straypath="cd ~/GitHub/straypathcom"

# Image processing (from your cdn script)
alias process-images="~/GitHub/straypathcom/cdn/remove_metadata.sh"

# ====================================================================
# Front-End Development Functions
# ====================================================================
# Create a new project with common front-end setup
function create-fe-project() {
  mkdir -p $1/src/{assets,components,styles,utils}
  touch $1/README.md
  cd $1
  npm init -y
  npm i -D eslint prettier eslint-config-prettier eslint-plugin-prettier
  echo "Front-end project structure created in $1"
}

# Optimize images in current directory
function optimize-images() {
  for file in *.{jpg,jpeg,png,gif}; do
    if [ -f "$file" ]; then
      echo "Optimizing $file..."
      imageoptim "$file"
    fi
  done
}

# Start a local web server in the current directory
function webserver() {
  local port=${1:-8000}
  echo "Starting web server at http://localhost:$port"
  python -m http.server $port
}

# Create a new React component
function new-component() {
  mkdir -p src/components/$1

  # Create component file
  cat > src/components/$1/$1.jsx << EOF
import React from 'react';
import './$1.css';

const $1 = (props) => {
  return (
    <div className="$1">
      $1 Component
    </div>
  );
};

export default $1;
EOF

  # Create CSS file
  cat > src/components/$1/$1.css << EOF
.$1 {
  /* Add your styles here */
}
EOF

  # Create test file
  cat > src/components/$1/$1.test.jsx << EOF
import React from 'react';
import { render, screen } from '@testing-library/react';
import $1 from './$1';

test('renders $1 component', () => {
  render(<$1 />);
  const element = screen.getByText(/$1 Component/i);
  expect(element).toBeInTheDocument();
});
EOF

  echo "$1 component created with CSS and test file"
}

# ====================================================================
# Additional Tool Configuration
# ====================================================================
# Angular CLI autocompletion
[ -x "$(command -v ng)" ] && source <(ng completion script)

# fnm - Fast Node Manager
if [ -x "$(command -v fnm)" ]; then
  eval "$(fnm env --use-on-cd)"
fi

# ====================================================================
# Environment Variables
# ====================================================================
# Store sensitive tokens in a separate file that isn't committed to Git
[ -f ~/.tokens.zsh ] && source ~/.tokens.zsh

# Front-end related environment variables
# export NODE_ENV="development"
export BROWSER="chrome"

# ====================================================================
# Powerlevel10k Configuration
# ====================================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# Added by Windsurf
export PATH="/Users/peterbenoit/.codeium/windsurf/bin:$PATH"
