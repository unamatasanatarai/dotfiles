#!/usr/bin/env bash

echo "==> Starting application installation..."

if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    
    echo "==> The Homebrew installer requires administrator privileges."
    echo "==> Please enter your Mac password when prompted to authenticate sudo."
    # The non-interactive Homebrew installer cannot prompt for your password,
    # so we explicitly ask for sudo authentication here first.
    sudo -v || { echo "Sudo authentication failed"; exit 1; }

    curl -fsSL -o /tmp/brew_install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh || { echo "Failed to download Homebrew installer"; exit 1; }

    if ! NONINTERACTIVE=1 bash /tmp/brew_install.sh; then
        echo "Error: Failed to install Homebrew." >&2
        exit 1
    fi
    
    # Depending on the system (e.g. Apple Silicon vs Intel), Homebrew might need to be added to the PATH manually here.
    # The brew installer typically installs to /opt/homebrew/bin/brew on Apple Silicon and /usr/local/bin/brew on Intel.
    if [[ -x /opt/homebrew/bin/brew ]]; then
        /opt/homebrew/bin/brew shellenv > /tmp/brew_env.sh
        source /tmp/brew_env.sh
    elif [[ -x /usr/local/bin/brew ]]; then
        /usr/local/bin/brew shellenv > /tmp/brew_env.sh
        source /tmp/brew_env.sh
    fi
    echo "==> Homebrew installed successfully!"
else
    echo "==> Homebrew is already installed."
fi

echo "==> Installing apps from Brewfile..."
brew bundle install --file=./configs/Brewfile || { echo "Failed to install apps from Brewfile"; exit 1; }

echo "==> Installing custom fonts..."
mkdir -p ~/Library/Fonts/ || { echo "Failed to create Fonts directory"; exit 1; }
# Copy fonts but don't fail the whole script if some font folders are missing
cp ./configs/fonts/source-code-pro/* ~/Library/Fonts/ 2>/dev/null || true
cp ./configs/fonts/archivo/*.ttf ~/Library/Fonts/ 2>/dev/null || true
cp ./configs/fonts/archivo/static/*.ttf ~/Library/Fonts/ 2>/dev/null || true

if command -v fc-cache &>/dev/null; then
    echo "==> Updating font cache..."
    fc-cache -fv > /dev/null || { echo "Failed to update font cache"; exit 1; }
fi

echo "==> Setting Homebrew bash as the default shell..."
# Determine brew's bash path (Apple Silicon vs Intel)
if [[ -x /opt/homebrew/bin/bash ]]; then
    BREW_BASH=/opt/homebrew/bin/bash
elif [[ -x /usr/local/bin/bash ]]; then
    BREW_BASH=/usr/local/bin/bash
else
    echo "Warning: Could not find Homebrew bash. Is 'brew install bash' complete?" >&2
    BREW_BASH=""
fi

if [[ -n "$BREW_BASH" ]]; then
    # Add brew bash to /etc/shells if it isn't already listed
    if ! grep -qF "$BREW_BASH" /etc/shells; then
        echo "==> Adding $BREW_BASH to /etc/shells (requires sudo)..."
        echo "$BREW_BASH" | sudo tee -a /etc/shells > /dev/null || { echo "Failed to update /etc/shells"; exit 1; }
    fi

    # Change the default shell only if it's not already set
    if [[ "$SHELL" != "$BREW_BASH" ]]; then
        echo "==> Changing default shell to $BREW_BASH..."
        chsh -s "$BREW_BASH" || { echo "Failed to change default shell"; exit 1; }
        echo "==> Default shell changed. Restart your terminal to use the new shell."
    else
        echo "==> Default shell is already $BREW_BASH."
    fi
fi

echo "==> Installation complete!"
