.DEFAULT_GOAL := help

.PHONY: help install dump-apps

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Run all installation scripts
	./scripts/prep-env.sh
	./scripts/install-brew.sh
	./scripts/install-macports.sh
	./scripts/install-fonts.sh
	$(MAKE) -C configs/.config/bash
	./scripts/setup-bash.sh
	./scripts/relink-config.sh
	./scripts/relink-home.sh
	./scripts/launch-services.sh
	./scripts/setup-macos.sh
	@echo "==> All done."

dump-apps: ## Dump installed Homebrew formulae and casks to Brewfile
	@brew bundle dump --file=configs/Brewfile --force
	@echo "==> Dumped Homebrew configuration to configs/Brewfile"
