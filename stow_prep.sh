#!/usr/bin/env bash

# --- Configuration ---
# !!! ADJUST THIS if your main dotfiles repository is elsewhere !!!
ARCH_CONFIG_DIR_DEFAULT="~/GitHub/arch_config"
# Expand tilde for ARCH_CONFIG_DIR
ARCH_CONFIG_DIR="${ARCH_CONFIG_DIR_DEFAULT/#\~/$HOME}"
INSTALL_SCRIPT_PATH="$ARCH_CONFIG_DIR/install.sh"

# --- Safety Prompt ---
echo "This script will attempt to back up existing configuration files that might conflict with stow."
echo "Backed-up files will be moved to a new directory like '~/dotfiles_backup_YYYYMMDD_HHMMSS'."
echo "It will then try to run '$INSTALL_SCRIPT_PATH'."
echo ""
read -p "ARE YOU SURE you want to continue? (y/N): " confirmation
if [[ "$confirmation" != "y" && "$confirmation" != "Y" ]]; then
  echo "Operation aborted by user."
  exit 1
fi
echo ""

# --- Backup Process ---
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

if [ ! -d "$BACKUP_DIR" ]; then
  echo "Error: Could not create backup directory '$BACKUP_DIR'. Aborting."
  exit 1
fi

echo "Starting backup of potentially conflicting files..."
echo "--------------------------------------------------"

# Function to move item if it exists
move_item() {
  local item_path="$1"
  local backup_name="$2"
  # Expand tilde in item_path if present at the beginning
  local expanded_item_path="${item_path/#\~/$HOME}"

  if [ -e "$expanded_item_path" ]; then # Checks if file or directory exists
    echo "Backing up: $expanded_item_path  ->  $BACKUP_DIR/$backup_name"
    if mv "$expanded_item_path" "$BACKUP_DIR/$backup_name"; then
      echo "  Successfully backed up."
    else
      echo "  ERROR: Failed to back up $expanded_item_path."
    fi
  else
    echo "Skipping (does not exist): $expanded_item_path"
  fi
}

# --- Items from ~/.config ---
echo "Processing ~/.config items..."
CONFIG_HOME="$HOME/.config"
# Individual files
move_item "$CONFIG_HOME/QtProject.conf" "QtProject.conf"
move_item "$CONFIG_HOME/mimeapps.list" "mimeapps.list"
move_item "$CONFIG_HOME/okular-generator-popplerrc" "okular-generator-popplerrc"
move_item "$CONFIG_HOME/okularpartrc" "okularpartrc"
move_item "$CONFIG_HOME/okularrc" "okularrc"

# Entire directories
move_item "$CONFIG_HOME/btop" "btop_dir"
move_item "$CONFIG_HOME/i3status" "i3status_dir"
move_item "$CONFIG_HOME/nvim-qt" "nvim-qt_dir"
move_item "$CONFIG_HOME/nvim" "nvim_dir"
move_item "$CONFIG_HOME/sway" "sway_dir"

# --- Items from ~/ (for ZSH) ---
echo ""
echo "Processing ZSH items in ~ ..."
move_item "$HOME/.zshrc" ".zshrc"
move_item "$HOME/.zshrc.pre-oh-my-zsh" ".zshrc.pre-oh-my-zsh"

# --- Items from ~/.ssh ---
# The main install.sh should ensure ~/.ssh exists with `mkdir -p ~/.ssh` before stowing.
# This backup script just moves files if they exist.
echo ""
echo "Processing SSH items in ~/.ssh ..."
SSH_HOME="$HOME/.ssh"
move_item "$SSH_HOME/config" "ssh_config"
move_item "$SSH_HOME/ssh_config_teleport" "ssh_config_teleport"

echo "--------------------------------------------------"
echo "Backup and move operations attempted."
echo "Your old files (if they existed) should be in: $BACKUP_DIR"
echo "Please review the output above for any errors during backup."
echo ""

# --- Run the main install.sh script ---
echo "Attempting to run your main dotfiles installation script..."
if [ -f "$INSTALL_SCRIPT_PATH" ]; then
  echo "Changing directory to $ARCH_CONFIG_DIR"
  cd "$ARCH_CONFIG_DIR" || {
    echo "ERROR: Could not cd to $ARCH_CONFIG_DIR. Aborting."
    exit 1
  }

  echo "Executing: bash $(basename "$INSTALL_SCRIPT_PATH")"
  echo "--------------------------------------------------"
  bash "$(basename "$INSTALL_SCRIPT_PATH")"
  echo "--------------------------------------------------"
  echo "Main installation script finished."
else
  echo "ERROR: Main installation script not found at $INSTALL_SCRIPT_PATH"
  echo "Please run it manually after ensuring backups are correct."
fi

echo ""
echo "Full process complete. Please check your applications and symlinks."
