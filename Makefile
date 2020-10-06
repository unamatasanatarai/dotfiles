SHELL:=/bin/bash
pwd := $(shell pwd)
config_dirs:=$(shell ls $(pwd)/.config)

install:
	echo "I'm installing things for you $(pwd)"
	# backup existing bash profile
	[ -f "~/.bash_profile" ] && mv ~/.bash_profile ~/.bash_profile.bkp
	link -s .bash_profile ~/.bash_profile

link:
	@for dir in $(config_dirs); do \
		ln -s $(pwd)/.config/$$dir ~/.config/$$dir \
	;done \

unlink:
	@for dir in $(config_dirs); do \
		[ -L ~/.config/$$dir ] && unlink ~/.config/$$dir; \
	done
