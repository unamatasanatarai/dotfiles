SHELL := /bin/bash
pwd := $(shell pwd)
config_dirs := $(shell ls $(pwd)/.config)
bin_dirs := $(shell ls $(pwd)/bin)
files := ".bash_profile" ".vimrc" ".tmux.conf"

.DEFAULT_GOAL := help

help:
	@echo "usage: make configure; make install"
	@echo ""
	@echo "Available targets:"
	@echo "    - configure		Prepare entire environment"
	@echo "    - install		Install everything"
	@echo "    - unlink		Uninstall everything"
	@echo "    - link		Link configurations"
	@echo "    - help		Display this message"
	@echo ""

configure:
	@echo "Create ~/bin directory"
	@if [ ! -d ~/bin ]; then mkdir ~/bin; fi

install: unlink link
	source ~/.bash_profile
	@echo -e "\n\033[32mRunning: macos.install-brew.sh\033[39m"
	./macos.install-brew.sh
	@echo -e "\n\033[32mRunning: macos.set-settings.sh\033[39m"
	./macos.set-settings.sh
	@echo "Congratulations!"

link:
	@echo -e "\n\033[32mRunning: link\033[39m"

	mv ~/.bash_profile ~/.bash_profile.bkp

	@for file in $(files); do \
		echo "link ~/$$file"; \
		ln -s $(pwd)/$$file ~/$$file; \
	done

	@for dir in $(config_dirs); do \
		echo "link ~/.config/$$dir"; \
		ln -s $(pwd)/.config/$$dir ~/.config/$$dir; \
	done

	@for file in $(bin_dirs); do \
		echo "link ~/bin/$$file"; \
		ln -s $(pwd)/bin/$$file ~/bin/$$file; \
	done 

unlink:
	@echo -e "\n\033[32mRunning: unlink\033[39m"

	@for file in $(files); do \
		if [ -L ~/$$file ]; then \
			echo "unlink ~/$$file"; \
			unlink ~/$$file; \
		fi \
	done

	@for dir in $(config_dirs); do \
		if [ -L ~/.config/$$dir ]; then \
			echo "unlink ~/.config/$$dir"; \
			unlink ~/.config/$$dir; \
		fi \
	done

	@for file in $(bin_dirs); do \
		if [ -L ~/bin/$$file ]; then \
			echo "unlink ~/bin/$$file"; \
			unlink ~/bin/$$file; \
		fi \
	done

	@if [ -f ~/.bash_profile.bkp ]; then \
		mv ~/.bash_profile.bkp ~/.bash_profile; \
	else\
		touch ~/.bash_profile; \
	fi

