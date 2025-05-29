#!/usr/bin/env bash

# Configs
stow -t ~/.config -S config/btop
stow -t ~/.config -S config/i3status
stow -t ~/.config -S config/nvim
stow -t ~/.config -S config/nvim-qt
stow -t ~/.config -S config/sway
stow -t ~/.config -S config/yay
stow -t ~/.config -S config/QtProject.conf
stow -t ~/.config -S config/mimeapps.list
stow -t ~/.config -S config/okular-generator-popplerrc
stow -t ~/.config -S config/okularpartrc
stow -t ~/.config -S config/okularrc

# ZSH
stow -t ~ -S zsh/*

#ssh
stow -t ~/.ssh -S ssh/*
