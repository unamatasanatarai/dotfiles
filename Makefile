.DEFAULT_GOAL := help

.PHONY: bootstrap install link configure dump help

help: ## Show this help message
	@bash -c 'while read -r line; do \
		if [[ $$line =~ ^([a-zA-Z_-]+):[^#]*##\ (.*)$$ ]]; then \
			printf "%-20s %s\n" "$${BASH_REMATCH[1]}" "$${BASH_REMATCH[2]}"; \
		fi \
	done < $(MAKEFILE_LIST)'

bootstrap: install-apps link configure ## Full machine setup: install apps, link dotfiles, configure macOS
	@echo "All done."

link: ## Symlink dotfiles and prepare XDG environment directories
	./_relink-config.sh
	./_relink-home.sh
	./_prep-env.sh

configure: ## Apply system defaults and preferences
	./_set-defaults.sh

install-apps: ## Install applications via Homebrew
	./_install-apps.sh

dump: ## Snapshot currently installed Brew packages to Brewfile
	brew bundle dump --force --describe --file=./configs/Brewfile
