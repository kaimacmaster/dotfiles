#!/bin/bash

# Define the backup directory
BACKUP_DIR=~/dotfiles_backup

# Function to move existing files or directories to the backup folder and create a symlink
backup_and_link() {
    local source=$1
    local target=$2

    # If target exists and is not a symlink, move it to backup
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up $target to $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR"
    fi

    # If the target is already a symlink pointing to the correct source, skip linking
    if [ -L "$target" ] && [ "$(readlink "$target")" == "$source" ]; then
        echo "$target is already correctly symlinked, skipping."
        return
    fi

    # Create or update the symlink
    echo "Creating symlink: $target -> $source"
    ln -sf "$source" "$target"
}

# Backup and create symlinks for dotfiles
backup_and_link ~/dotfiles/config/nvim ~/.config/nvim
backup_and_link ~/dotfiles/config/kitty ~/.config/kitty
backup_and_link ~/dotfiles/config/alacritty ~/.config/alacritty
backup_and_link ~/dotfiles/config/hypr ~/.config/hypr
backup_and_link ~/dotfiles/config/waybar ~/.config/waybar
backup_and_link ~/dotfiles/config/i3/config ~/.config/i3/config
backup_and_link ~/dotfiles/scripts/bash_aliases.sh ~/.bash_aliases
backup_and_link ~/dotfiles/scripts/bash_functions.sh ~/.bash_functions

# Function to add a line to a shell configuration file if it does not already exist
add_source_line() {
    local file=$1
    local line=$2

    if [ -f "$file" ]; then
        if ! grep -qF "$line" "$file"; then
            echo "Adding '$line' to $file"
            echo "$line" >>"$file"
        else
            echo "'$line' already exists in $file"
        fi
    else
        echo "$file not found. Creating $file and adding '$line'."
        echo "$line" >"$file"
    fi
}

# Add source lines to .zshrc
add_source_line ~/.zshrc "source ~/.bash_aliases"
add_source_line ~/.zshrc "source ~/.bash_functions"

# Add source lines and prompt setup to .bashrc (for machines using bash)
add_source_line ~/.bashrc "if [ -f ~/dotfiles/scripts/bash_functions.sh ]; then"
add_source_line ~/.bashrc "    . ~/dotfiles/scripts/bash_functions.sh"
add_source_line ~/.bashrc "fi"
add_source_line ~/.bashrc "if [ -f ~/dotfiles/scripts/bash_aliases.sh ]; then"
add_source_line ~/.bashrc "    . ~/dotfiles/scripts/bash_aliases.sh"
add_source_line ~/.bashrc "fi"
add_source_line ~/.bashrc 'PS1="\[\033[33m\]\u\[\033[0m\]:\[\033[35m\]\w\[\033[0m\]\$ "'

# Detect OS and adjust configurations
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Applying Linux-specific configurations..."

    # Define required packages and check if they're installed.
    # Using 'rg' for ripgrep, and 'inotifywait' for inotify-tools.
    required_packages=(fzf rg luarocks inotifywait)
    missing_packages=()

    for pkg in "${required_packages[@]}"; do
        if ! command -v "$pkg" &>/dev/null; then
            missing_packages+=("$pkg")
        fi
    done

    # If not in a WSL environment, check for wl-clipboard (using wl-copy).
    if ! grep -qiE "(microsoft|wsl)" /proc/version; then
        if ! command -v wl-copy &>/dev/null; then
            missing_packages+=("wl-clipboard")
        fi
    fi

    if [ ${#missing_packages[@]} -gt 0 ]; then
        echo "Warning: The following packages are missing: ${missing_packages[@]}"
        echo "Please install them as appropriate for your distribution (e.g., using apt, dnf, or pacman)."
    else
        echo "All required packages are installed."
    fi

    # Check if running in a WSL environment by searching /proc/version.
    if grep -qiE "(microsoft|wsl)" /proc/version; then
        echo "WSL environment detected. Configuring Neovim clipboard integration."

        # Write a Neovim configuration file for WSL clipboard integration using win32yank.
        NVIM_CLIPBOARD_FILE=~/.config/nvim/lua/clipboard_wsl.lua
        NVIM_CLIPBOARD_CONFIG='
-- WSL Clipboard configuration for Neovim using win32yank
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = function()
        return vim.fn.systemlist("powershell.exe -Command Get-Clipboard | tr -d '\r'")
      end,
      ["*"] = function()
        return vim.fn.systemlist("powershell.exe -Command Get-Clipboard | tr -d '\r'")
      end,
    },
    cache_enabled = 0,
  } 
end
'
        mkdir -p "$(dirname "$NVIM_CLIPBOARD_FILE")"
        echo "$NVIM_CLIPBOARD_CONFIG" >"$NVIM_CLIPBOARD_FILE"
        echo "Neovim WSL clipboard configuration written to $NVIM_CLIPBOARD_FILE"
    fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Applying macOS-specific configurations..."
    # Add macOS-specific configurations here
fi

echo "Setup complete! Backups are stored in $BACKUP_DIR."
