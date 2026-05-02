.DEFAULT_GOAL := help

.PHONY: help install select-yabai select-aerospace brew-dump

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Run all installation scripts
	./_prep-env.sh
	./_install-apps.sh
	./_relink-config.sh
	./_relink-home.sh
	./_set-defaults.sh
	@echo "==> All done."

SKHD_DIR := $(HOME)/.config/skhd

select-yabai: ## Switch skhd to yabai mode
	@command -v yabai >/dev/null 2>&1 || { echo "==> Error: yabai is not installed."; exit 1; }
	@cd $(SKHD_DIR) && rm -f active_wm && ln -s yabai active_wm
	@osascript -e 'tell application "AeroSpace" to quit' || true
	@skhd --restart-service
	@yabai --restart-service
	@echo "==> Switched skhd to yabai mode"

select-aerospace: ## Switch skhd to AeroSpace mode
	@cd $(SKHD_DIR) && rm -f active_wm && ln -s aerospace active_wm
	@yabai --stop-service 2>/dev/null || true
	@skhd --restart-service
	@open -a AeroSpace
	@echo "==> Switched skhd to AeroSpace mode"

brew-dump: ## Dump installed Homebrew formulae and casks to Brewfile
	@brew bundle dump --file=configs/Brewfile --force
	@echo "==> Dumped Homebrew configuration to configs/Brewfile"
