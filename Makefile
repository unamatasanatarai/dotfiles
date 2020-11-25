SHELL := /bin/bash
pwd := $(shell pwd)

configs_dir := "${pwd}/configs"
backups_dir := ~/.cache/.dotfiles_backups

required_dirs := ~/.cache ~/.cache/vim/tmp/swp ~/.cache/vim/tmp/backup ~/.cache/vim/tmp/undo ~/bin ~/.config ${backups_dir}
cleanup_dirs := ~/.cache/vim ${backups_dir}
files_backupped := $(shell [ -d ${backups_dir} ] && ls -A ${backups_dir} || echo "" )

dotfiles := .bash_profile .tmux.conf .vim .vimrc .config/bash .config/iterm bin

green := \033[1;32m
red := \033[1;31m
reset := \033[0m

.DEFAULT_GOAL := help

help:
	@echo "usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@echo "    - install		Run all installation targets"
	@echo "    - configure		Prepare the environment"
	@echo "    - osx		Update defaults for macos"
	@echo "    - uninstall		Remove our dotfiles and restore backupped files"
	@echo "    - help		Display this message"
	@echo ""

install: configure backup link vim composer osx
	@echo -e "\n All done.\n You may want to restart your terminal, or \`source ~/.bash_profile\`."

configure:
	@for dir in ${required_dirs}; do \
		[ ! -d $$dir ] && mkdir -p $$dir && echo -e " ${green}Created${reset}: $$dir" || echo -e " ${red}Directory exists${reset}: $$dir"; \
	done
	@echo -e "\n Configured."

backup:
	@for file in ${dotfiles}; do \
		[[ ! -L ~/$$file && ( -d ~/$$file || -f ~/$$file ) ]] && mv ~/$$file ${backups_dir} && echo -e " ${green}Backup${reset}: $$file" || echo -e " ${red}Backup skip [no-file]${reset}: ~/$$file"; \
	done

link:
	@for file in ${dotfiles}; do \
		[ $$file != bin ] && [ ! -L ~/$$file ] && ln -s ${configs_dir}/$$file ~/$$file && echo -e " ${green}Linked${reset}: $$file" || echo -e " ${red}Link skip [link-exists]${reset}: $$file"; \
	done
	@[ ! -L ~/bin/bitbar ] && ln -s ${configs_dir}/bin/bitbar ~/bin/bitbar && echo -e " ${green}Linked${reset}: ~/bin/bitbar" || echo -e " ${red}Link skip [link-exists]${reset}: ~/bin/bitbar"
	@[ ! -L ~/bin/dotfiles ] && ln -s ${configs_dir}/bin/dotfiles ~/bin/dotfiles && echo -e " ${green}Linked${reset}: ~/bin/dotfiles" || echo -e " ${red}Link skip [link-exists]${reset}: ~/bin/dotfiles"

vim:
	./scripts/update-vim-configs

composer:
	./scripts/install-composer
	@echo -e " ${green}Completed${reset}: composer"

osx:
	./scripts/osx.set-defaults
	@echo -e " ${green}Completed${reset}: defaults"
	./scripts/osx.install-brew
	@echo -e " ${green}Completed${reset}: brew"
	./scripts/osx.install-temp
	@echo -e " ${green}Completed${reset}: temperature"
	./scripts/osx.install-keylogger
	@echo -e " ${green}Completed${reset}: keylogger"
	@echo -e "\n\n${green} Logout & Login for some settings to take effect${reset}\n"

uninstall: unlink restore clean
	@echo -e "\n Sorry to see you go.\n"

unlink:
	@for file in ${dotfiles}; do \
		[ $$file != bin ] && [ -L ~/$$file ] && unlink ~/$$file && echo -e " ${green}unlink${reset}: $$file" || echo -e " ${red}Unlink skip[not-a-link]${reset}: $$file"; \
	done
	@[ -L ~/bin/bitbar ] && unlink ~/bin/bitbar && echo -e " ${green}unlink${reset}: bin/bitbar" || echo -e " ${red}Unlink skip[not-a-link]${reset}: bin/bitbar";
	@[ -L ~/bin/dotfiles ] && unlink ~/bin/dotfiles && echo -e " ${green}unlink${reset}: bin/dotfiles" || echo -e " ${red}Unlink skip[not-a-link]${reset}: ~/bin/dotfiles";

restore:
	@for file in ${files_backupped}; do \
		mv ${backups_dir}/$$file ~/$$file; \
		echo -e " ${green}Restored${reset}: ~/$$file"; \
	done

clean:
	@for dir in ${cleanup_dirs}; do \
		[ -d $$dir ] && rm -rf $$dir && echo -e " ${green}Cleanup${reset}: $$dir" || echo -e " ${red}Cleanup skip[not-a-directory]${reset}: $$dir"; \
	done

