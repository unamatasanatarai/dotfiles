.PHONY: install brew-dump

install:
	./_prep-env.sh
	./_install-apps.sh
	./_relink-config.sh
	./_relink-home.sh
	./_set-defaults.sh
	@echo "All done."

brew-dump:
	brew bundle dump --force --file=./configs/Brewfile
