#!/bin/bash

# Variables
DOTFILES_DIR=$(pwd)
BACKUP_DIR="$HOME/dotfiles_backup"

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
	echo "Creating backup directory at $BACKUP_DIR"
	mkdir -p "$BACKUP_DIR"
fi

# Function to create symlinks and backup existing files
create_symlink() {
	local source_file=$1
	local target_file=$2

	if [ -e "$target_file" ]; then
		echo "Backing up $target_file to $BACKUP_DIR"
		mv "$target_file" "$BACKUP_DIR/"
	fi

	echo "Creating symlink for $source_file"
	ln -s "$source_file" "$target_file"
}

# Symlink .eslintrc.json
create_symlink "$DOTFILES_DIR/.eslintrc.json" "$HOME/.eslintrc.json"

# Symlink .prettierrc
create_symlink "$DOTFILES_DIR/.prettierrc" "$HOME/.prettierrc"

# Symlink VSCode settings
create_symlink "$DOTFILES_DIR/.vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json" # macOS
#create_symlink "$DOTFILES_DIR/.vscode/settings.json" "$HOME/.config/Code/User/settings.json" # Linux
#create_symlink "$DOTFILES_DIR/.vscode/settings.json" "$APPDATA/Code/User/settings.json" # Windows

echo "Dotfiles setup complete!"
