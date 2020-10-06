SHELL := /bin/bash
pwd := $(shell pwd)
config_dirs := $(shell ls $(pwd)/.config)
bin_dirs := $(shell ls $(pwd)/bin)

.DEFAULT_GOAL := help

help:
	@echo "usage: make configure; make install"
	@echo ""
	@echo "Available targets:"
	@echo "    - configure		Prepare entire environment"
	@echo "    - install		Install everything"
	@echo "    - clean		Uninstall everything"
	@echo "    - link		Link configurations"
	@echo "    - help		Display this message"
	@echo ""

configure:
	@echo "Create ~/bin directory"
	@if [ ! -d ~/bin ]; then mkdir ~/bin; fi

install: clean link
	source ~/.bash_profile

	@echo "Congratulations!"

link:
	@echo -e "\n\033[32mRunning: link\033[39m"

	mv ~/.bash_profile ~/.bash_profile.bkp
	ln -s $(pwd)/.bash_profile ~/.bash_profile
	ln -s $(pwd)/.tmux.conf ~/.tmux.conf
	ln -s $(pwd)/.vimrc ~/.vimrc

	@for dir in $(config_dirs); do \
		echo "link ~/.config/$$dir"; \
		ln -s $(pwd)/.config/$$dir ~/.config/$$dir; \
	done

	@for file in $(bin_dirs); do \
		echo "link ~/bin/$$file"; \
		ln -s $(pwd)/bin/$$file ~/bin/$$file; \
	done 

clean:
	@echo -e "\n\033[32mRunning: clean\033[39m"

	unlink ~/.tmux.conf
	unlink ~/.vimrc
	unlink ~/.bash_profile
	touch ~/.bash_profile

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

