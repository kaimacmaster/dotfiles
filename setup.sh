#!/bin/bash

# Define the backup directory
BACKUP_DIR=~/dotfiles_backup

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to move existing files or directories to the backup folder
backup_and_link() {
    local source=$1
    local target=$2

    # Check if the target already exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up $target to $BACKUP_DIR"
        mv "$target" "$BACKUP_DIR"
    fi

    # If the target is a symlink pointing to the same source, skip
    if [ "$(readlink "$target")" == "$source" ]; then
        echo "$target is already correctly symlinked, skipping."
        return
    fi

    # Create the symlink
    echo "Creating symlink: $target -> $source"
    ln -sf "$source" "$target"
}

# Backup and create symlinks for each file or directory
backup_and_link ~/dotfiles/config/nvim ~/.config/nvim
backup_and_link ~/dotfiles/config/kitty ~/.config/kitty
backup_and_link ~/dotfiles/config/alacritty ~/.config/alacritty
backup_and_link ~/dotfiles/config/hypr ~/.config/hypr
backup_and_link ~/dotfiles/zsh_aliases ~/.zsh_aliases

# Add a line to include aliases file in .zshrc if it doesn't exist
ALIAS_FILE=~/.zsh_aliases
if ! grep -q "source $ALIAS_FILE" ~/.zshrc; then
    echo "Adding source line for $ALIAS_FILE to ~/.zshrc"
    echo "source $ALIAS_FILE" >> ~/.zshrc
fi

# Detect OS and adjust configurations
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Applying Linux-specific configurations..."
    # Add Linux-specific configurations here, like font size adjustments
    # For example: sed -i 's/font_size=12/font_size=14/' ~/.config/alacritty/alacritty.yml
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Applying macOS-specific configurations..."
    # Add macOS-specific configurations here
fi

echo "Setup complete! Backups are stored in $BACKUP_DIR."

