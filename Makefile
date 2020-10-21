SHELL := /bin/bash
pwd := $(shell pwd)
configs_dir = "${pwd}/configs"
backups_dir = ~/.dotfiles_backups
files := $(shell ls -A ${configs_dir})
files_backupped := $(shell [ -d ${backups_dir} ] && ls -A ${backups_dir} || echo "" )

green := \033[1;32m
red := \033[1;31m
reset := \033[0m

.DEFAULT_GOAL := help

help:
	@echo "usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@echo "    - install		Run all installation targets"
	@echo "    - osx		Update defaults for macos"
	@echo "    - osxapps		Install my utility apps"
	@echo "    - brew		Install brew and apps"
	@echo "    - composer		Install php composer"
	@echo "    - uninstall		Remove our dotfiles and restore backupped files"
	@echo "    - help		Display this message"
	@echo ""

install: prepare backup link
	@echo -e "\n All done.\n You may want to restart your terminal, or \`source ~/.bash_profile\`."

prepare:
	@[ ! -d ${backups_dir} ] && mkdir ${backups_dir} && echo -e " ${green}Created${reset}: ${backups_dir}" || echo -e " ${red}Directory exists${reset}: ${backups_dir}"

backup:
	@for file in ${files}; do \
		[[ ! -L ~/$$file && ( -d ~/$$file || -f ~/$$file ) ]] && mv ~/$$file ${backups_dir} && echo -e " ${green}Backup${reset}: $$file" || echo -e " ${red}Backup skip [no-file]${reset}: ~/$$file"; \
	done

link:
	@for file in ${files}; do \
		[ ! -L ~/$$file ] && ln -s ${configs_dir}/$$file ~/$$file && echo -e " ${green}Linked${reset}: $$file" || echo -e " ${red}Link skip [link-exists]${reset}: $$file"; \
	done

brew:
	./scripts/osx.install-brew

composer:
	./scripts/install-composer
	@echo -e " ${green}Completed${reset}: composer"

osxapps:
	./scripts/osx.install-temp
	@echo -e " ${green}Completed${reset}: temperature"
	./scripts/osx.install-keylogger
	@echo -e " ${green}Completed${reset}: keylogger"

osx:
	./scripts/osx.set-defaults
	@echo -e "\n\n${green} Logout & Login for some settings to take effect${reset}\n"

uninstall: unlink restore cleanup
	@echo -e "\n Sorry to see you go.\n"

unlink:
	@for file in ${files}; do \
		[ -L ~/$$file ] && unlink ~/$$file && echo -e " ${green}unlink${reset}: $$file" || echo -e " ${red}Unlink skip[not-a-link]${reset}: $$file"; \
	done

restore:
	@for file in ${files_backupped}; do \
		mv ${backups_dir}/$$file ~/$$file; \
		echo -e " ${green}Restored${reset}: ~/$$file"; \
	done 

cleanup:
	@[ -d ${backups_dir} ] && rm -rf ${backups_dir} && echo -e " ${green}Cleanup${reset}: ${backups_dir}" || echo -e " ${red}Cleanup skip[not-a-directory]${reset}: ${backups_dir}";

