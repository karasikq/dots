#!/bin/sh
ZSHRC="$HOME/.zshrc"
NEW_ZSHRC="$HOME/.config/zsh/.zshrc"

if [ -f "$ZSHRC" ]; then
    mv "$ZSHRC" "${ZSHRC}.backup"
    echo "Backup of .zshrc created at ${ZSHRC}.backup."
fi

ln -s -T "$NEW_ZSHRC" "$ZSHRC"
echo "Symbolic link created: $NEW_ZSHRC -> $ZSHRC"
