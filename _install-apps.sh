#!/usr/bin/env bash
set -e

echo "==> Starting application installation..."

if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    
    echo "==> The Homebrew installer requires administrator privileges."
    echo "==> Please enter your Mac password when prompted to authenticate sudo."
    # The non-interactive Homebrew installer cannot prompt for your password,
    # so we explicitly ask for sudo authentication here first.
    sudo -v

    if ! NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        echo "Error: Failed to install Homebrew." >&2
        exit 1
    fi
    
    # Depending on the system (e.g. Apple Silicon vs Intel), Homebrew might need to be added to the PATH manually here.
    # The brew installer typically installs to /opt/homebrew/bin/brew on Apple Silicon and /usr/local/bin/brew on Intel.
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo "==> Homebrew installed successfully!"
else
    echo "==> Homebrew is already installed."
fi

echo "==> Installing apps from Brewfile..."
brew bundle install --file=./configs/Brewfile

echo "==> Installing custom fonts..."
mkdir -p ~/Library/Fonts/
# Copy fonts but don't fail the whole script if some font folders are missing
cp ./configs/fonts/source-code-pro/* ~/Library/Fonts/ 2>/dev/null || true
cp ./configs/fonts/archivo/*.ttf ~/Library/Fonts/ 2>/dev/null || true
cp ./configs/fonts/archivo/static/*.ttf ~/Library/Fonts/ 2>/dev/null || true

if command -v fc-cache &>/dev/null; then
    echo "==> Updating font cache..."
    fc-cache -fv > /dev/null
fi

echo "==> Installation complete!"
