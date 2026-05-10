#!/usr/bin/env bash
REPO_ROOT="$(cd -- "${BASH_SOURCE[0]%/*}/.." && pwd -P)"

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
		eval "$(/opt/homebrew/bin/brew shellenv)"
	elif [[ -x /usr/local/bin/brew ]]; then
		eval "$(/usr/local/bin/brew shellenv)"
	fi
fi

brew tap nikitabobko/tap
echo "==> Installing nikitabobko/tap/aerospace..."
brew install --cask nikitabobko/tap/aerospace || {
	echo "Failed to install aerospace"
	exit 1
}
