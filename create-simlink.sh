#!/bin/sh
ZSHRC="$HOME/.zshrc"
NEW_ZSHRC="$HOME/.config/zsh/.zshrc"

if [ -f "$ZSHRC" ]; then
    mv "$ZSHRC" "${ZSHRC}.backup"
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
