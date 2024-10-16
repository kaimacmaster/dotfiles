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

    # Create the symlink
    echo "Creating symlink: $target -> $source"
    ln -sf "$source" "$target"
}

# Backup and create symlinks for each file or directory
backup_and_link ~/dotfiles/.zshrc ~/.zshrc
backup_and_link ~/dotfiles/.config/nvim ~/.config/nvim
backup_and_link ~/dotfiles/.config/kitty ~/.config/kitty
backup_and_link ~/dotfiles/.config/alacritty ~/.config/alacritty
backup_and_link ~/dotfiles/.config/hypr ~/.config/hypr

echo "Setup complete! Backups are stored in $BACKUP_DIR."
