#!/usr/bin/env bash

## >> BREW
if ! command -v brew &>/dev/null; then
	echo "Homebrew is not installed. Installing Homebrew..."

	echo "==> The Homebrew installer requires administrator privileges."
	echo "==> Please enter your Mac password when prompted to authenticate sudo."

	sudo -v || {
		echo "Sudo authentication failed"
		exit 1
	}

	curl -fsSL -o /tmp/brew_install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh || {
		echo "Failed to download Homebrew installer"
		exit 1
	}

	if ! NONINTERACTIVE=1 bash /tmp/brew_install.sh; then
		echo "Error: Failed to install Homebrew." >&2
		exit 1
	fi

	if [[ -x /opt/homebrew/bin/brew ]]; then
		/opt/homebrew/bin/brew shellenv >/tmp/brew_env.sh
		source /tmp/brew_env.sh
	elif [[ -x /usr/local/bin/brew ]]; then
		/usr/local/bin/brew shellenv >/tmp/brew_env.sh
		source /tmp/brew_env.sh
	fi
fi

echo "==> Installing apps from Brewfile..."
brew bundle install --file=./configs/Brewfile --no-upgrade || {
	echo "Failed to install apps from Brewfile"
	exit 1
}

# >> MACPORTS
echo "==> Setting up MacPorts..."
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

if ! command -v port >/dev/null 2>&1; then
	echo "MacPorts is not installed. Installing MacPorts..."

	echo "==> The MacPorts installer requires administrator privileges."
	echo "==> Please enter your Mac password when prompted to authenticate sudo."

	curl -fL "https://github.com/macports/macports-base/releases/download/v2.12.5/MacPorts-2.12.5-12-Monterey.pkg" -o /tmp/M.pkg
	sudo installer -pkg /tmp/M.pkg -target /
fi

if [[ -f "$FILE" ]]; then
	echo "==> Installing ports from "./configs/MacPortsfile"..."
	sudo port install $(cat "./configs/MacPortsfile")
fi
echo "==> Reclaiming disk space from MacPorts..."
sudo port reclaim -uNqc

# >> FONTS
echo "==> Installing custom fonts..."
mkdir -p ~/Library/Fonts/ || {
	echo "Failed to create Fonts directory"
	exit 1
}
cp ./configs/fonts/source-code-pro/* ~/Library/Fonts/ 2>/dev/null || true
cp ./configs/fonts/archivo/*.ttf ~/Library/Fonts/ 2>/dev/null || true
cp ./configs/fonts/archivo/static/*.ttf ~/Library/Fonts/ 2>/dev/null || true

if command -v fc-cache &>/dev/null; then
	echo "==> Updating font cache..."
	fc-cache -fv >/dev/null || {
		echo "Failed to update font cache"
		exit 1
	}
fi

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

# >> SERVICES
echo "==> Starting services and opening apps..."

if command -v skhd &>/dev/null; then
	echo "    Starting or restarting skhd..."
	skhd --restart-service 2>/dev/null || skhd --start-service || echo "    Failed to start skhd"
fi

if [ -d "/Applications/LuLu.app" ]; then
	echo "    Starting LuLu..."
	open "/Applications/LuLu.app" || echo "    Failed to start LuLu"
fi

echo "==> Installation complete!"
