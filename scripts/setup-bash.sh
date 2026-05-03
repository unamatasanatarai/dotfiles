#!/usr/bin/env bash

echo "==> Setting Homebrew bash as the default shell..."

if [[ -x /opt/homebrew/bin/bash ]]; then
    BREW_BASH=/opt/homebrew/bin/bash
elif [[ -x /usr/local/bin/bash ]]; then
    BREW_BASH=/usr/local/bin/bash
else
    echo "Warning: Could not find Homebrew bash. Is 'brew install bash' complete?" >&2
    BREW_BASH=""
fi

if [[ -n "$BREW_BASH" ]]; then
    if ! grep -qF "$BREW_BASH" /etc/shells; then
        echo "==> Adding $BREW_BASH to /etc/shells (requires sudo)..."
        echo "$BREW_BASH" | sudo tee -a /etc/shells >/dev/null || {
            echo "Failed to update /etc/shells"
            exit 1
        }
    fi

    if [[ "$SHELL" != "$BREW_BASH" ]]; then
        echo "==> Changing default shell to $BREW_BASH..."
        chsh -s "$BREW_BASH" || {
            echo "Failed to change default shell"
            exit 1
        }
        echo "==> Default shell changed. Restart your terminal to use the new shell."
    else
        echo "==> Default shell is already $BREW_BASH."
    fi
fi
