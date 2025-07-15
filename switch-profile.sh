#!/bin/bash

# Profile switcher for Nix Dots
# Usage: ./switch-profile.sh [profile-name]

set -e

PROFILES=("arch" "macos")
DEFAULT_PROFILE="arch"

if [ $# -eq 0 ]; then
    echo "Available profiles:"
    for profile in "${PROFILES[@]}"; do
        if [ "$profile" = "$DEFAULT_PROFILE" ]; then
            echo "  $profile (default)"
        else
            echo "  $profile"
        fi
    done
    echo ""
    echo "Usage: $0 [profile-name]"
    echo "Example: $0 arch-gaming"
    exit 1
fi

PROFILE="$1"
USERNAME="cbate"

# Validate profile
if [[ ! " ${PROFILES[@]} " =~ " ${PROFILE} " ]]; then
    echo "Error: Invalid profile '$PROFILE'"
    echo "Available profiles: ${PROFILES[*]}"
    exit 1
fi

echo "Switching to profile: $PROFILE"
echo "User: $USERNAME"
echo ""

nix run home-manager/master -- switch --flake .#$USERNAME@$PROFILE

echo ""
echo "Profile '$PROFILE' applied successfully!"
echo ""