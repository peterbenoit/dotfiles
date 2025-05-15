#!/bin/bash

OUTPUT_DIR="docs/_installed"
mkdir -p "$OUTPUT_DIR"

echo "Saving Homebrew formula list..."
brew list --formula > "$OUTPUT_DIR/brew-formula.txt"

echo "Saving Homebrew cask list..."
brew list --cask > "$OUTPUT_DIR/brew-cask.txt"

echo "Saving Homebrew taps..."
brew tap > "$OUTPUT_DIR/brew-tap.txt"

echo "Saving global npm packages..."
npm list -g --depth=0 > "$OUTPUT_DIR/npm-global.txt"

echo "Saving global pip3 packages..."
pip3 list > "$OUTPUT_DIR/pip3.txt"

echo "Saving pyenv versions..."
if command -v pyenv >/dev/null 2>&1; then
  pyenv versions > "$OUTPUT_DIR/pyenv-versions.txt"
else
  echo "pyenv not found" > "$OUTPUT_DIR/pyenv-versions.txt"
fi

echo "Saving Deno info..."
if command -v deno >/dev/null 2>&1; then
  deno info > "$OUTPUT_DIR/deno-info.txt"
else
  echo "deno not found" > "$OUTPUT_DIR/deno-info.txt"
fi

echo "Saving VS Code extensions..."
code --list-extensions > "$OUTPUT_DIR/vscode-extensions.txt"

echo "Saving tool paths..."
which starship gh exa zoxide bat fd rg docker node python3 git > "$OUTPUT_DIR/paths.txt"

echo "Environment audit complete. Results saved to $OUTPUT_DIR."
