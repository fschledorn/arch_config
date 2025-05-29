#!/usr/bin/env bash

# Ensure target directories exist (good practice, though stow might create some)
mkdir -p ~/.config
mkdir -p ~/.ssh

# --- Configs for ~/.config ---
# This command will symlink:
#   arch_config/config/btop         -> ~/.config/btop
#   arch_config/config/i3status     -> ~/.config/i3status
#   arch_config/config/nvim         -> ~/.config/nvim
#   arch_config/config/nvim-qt      -> ~/.config/nvim-qt
#   arch_config/config/sway         -> ~/.config/sway
#   arch_config/config/QtProject.conf -> ~/.config/QtProject.conf
#   arch_config/config/mimeapps.list  -> ~/.config/mimeapps.list
#   ...and so on for all files and directories directly under arch_config/config/
echo "Stowing general configurations into ~/.config..."
stow -v -t ~/.config -S config # Assumes 'config' is a directory in the CWD

# --- ZSH ---
# This will symlink contents of 'arch_config/zsh/' into '~/'
# e.g., arch_config/zsh/.zshrc -> ~/.zshrc
echo "Stowing ZSH configurations into ~..."
stow -v -t ~ -S zsh

# --- SSH ---
# This will symlink contents of 'arch_config/ssh/' into '~/.ssh/'
# e.g., arch_config/ssh/config -> ~/.ssh/config
echo "Stowing SSH configurations into ~/.ssh..."
stow -v -t ~/.ssh -S ssh

echo "Dotfiles installation script finished."
