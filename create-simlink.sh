#!/bin/sh
ZSHRC="$HOME/.zshrc"
NEW_ZSHRC="$HOME/.config/zsh/.zshrc"

if [ -f "$ZSHRC" ]; then
    original_file=$(readlink -f "$ZSHRC")
    cp "$original_file" "${ZSHRC}.backup"
    rm "$ZSHRC"
    echo "Backup of .zshrc created at ${ZSHRC}.backup."
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ln -s -T "$NEW_ZSHRC" "$ZSHRC"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ln -s "$NEW_ZSHRC" "$ZSHRC"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi
