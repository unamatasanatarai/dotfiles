SHELL := /bin/bash
pwd := $(shell pwd)

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
	./dotfiles configure
	
install: link
	echo "add macos install scripts"

link:
	./dotfiles link

unlink:
	./dotfiles unlink

