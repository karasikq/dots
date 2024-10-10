#!/bin/bash

echo "Updating submodules..."
git submodule update --init --recursive

ZSH_DIR="$HOME/.config/zsh"
NVIM_DIR="$HOME/.config/nvim"

show_menu() {
    echo "Select an option:"
    echo "1. Override directory"
    echo "2. Backup old directory with .backup extension"
    echo "3. Abort"
    read -p "Enter your choice [1-3]: " choice
    return $choice
}

install() {
    cp -r .config/zsh "$HOME/.config"
    cp -r .config/nvim "$HOME/.config"
    echo "Installed."
}

if [ -d "$ZSH_DIR" ] || [ -d "$NVIM_DIR" ]; then
    if [ -d "$ZSH_DIR" ]; then
        echo "zsh config already exists"
    fi
    if [ -d "$NVIM_DIR" ]; then
        echo "nvim config already exists"
    fi
    show_menu
    choice=$?

    case $choice in
        1)
            install
            ;;
        2)
            if [ -d "$ZSH_DIR" ]; then
                mv "$ZSH_DIR" "${ZSH_DIR}.backup"
                echo "Backup of zsh directory created at $ZSH_DIR.backup."
            fi
            if [ -d "$NVIM_DIR" ]; then
                mv "$NVIM_DIR" "${NVIM_DIR}.backup"
                echo "Backup of nvim directory created at $NVIM_DIR.backup."
            fi
            install
            ;;
        3)
            echo "Operation aborted."
            exit 0
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
else
    install
fi

./create-simlink.sh
