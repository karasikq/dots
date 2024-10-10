#!/bin/sh
if [ ! -d "$HOME/.config/zsh" ]; then
    echo "Source directory $HOME/.config/zsh does not exist."
else
    mkdir -p .config/zsh
    cp -r "$HOME/.config/zsh" .config/
    echo "Copied zsh configuration."
fi

if [ ! -d "$HOME/.config/nvim" ]; then
    echo "Source directory $HOME/.config/nvim does not exist."
else
    mkdir -p .config/nvim
    cp -r "$HOME/.config/nvim" .config/
    echo "Copied nvim configuration."
fi
