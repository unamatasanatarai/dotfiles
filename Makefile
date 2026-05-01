.DEFAULT_GOAL := help

.PHONY: help install select-yabai select-aerospace

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
	@cd $(SKHD_DIR) && rm -f active_wm && ln -s yabai active_wm
	@skhd --restart-service
	@yabai --restart-service
	@echo "==> Switched skhd to yabai mode"

select-aerospace: ## Switch skhd to AeroSpace mode
	@cd $(SKHD_DIR) && rm -f active_wm && ln -s aerospace active_wm
	@skhd --restart-service
	@open -a AeroSpace
	@echo "==> Switched skhd to AeroSpace mode"
