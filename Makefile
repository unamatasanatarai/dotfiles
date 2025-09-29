.PHONY: all dotfiles osx apps brewdump

all: dotfiles osx apps
	@echo "All done."

dotfiles:
	./_relink-config.sh
	./_relink-home.sh
	./_prep-env.sh

osx:
	./_set-defaults.sh

apps:
	./_install-apps.sh

brewdump:
	brew bundle dump --force --describe --file=./configs/Brewfile
