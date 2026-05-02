.DEFAULT_GOAL := help

.PHONY: help install brew-dump

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Run all installation scripts
	./_prep-env.sh
	./_install-apps.sh
	./_relink-config.sh
	./_relink-home.sh
	./_set-defaults.sh
	@echo "==> All done."

brew-dump: ## Dump installed Homebrew formulae and casks to Brewfile
	@brew bundle dump --file=configs/Brewfile --force
	@echo "==> Dumped Homebrew configuration to configs/Brewfile"
