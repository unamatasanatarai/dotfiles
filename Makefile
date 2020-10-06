SHELL:=/bin/bash
pwd := $(shell pwd)
config_dirs:=$(shell ls $(pwd)/.config)

install: clean link
	@echo -e "\n\033[32mRunning: install\033[39m"
	source ~/.bash_profile

link: link_bash_profile
	@echo -e "\n\033[32mRunning: link\033[39m"
	@for dir in $(config_dirs); do \
		echo "link ~/.config/$$dir"; \
		ln -s $(pwd)/.config/$$dir ~/.config/$$dir \
	;done \

link_bash_profile:
	@echo -e "\n\033[32mRunning: link_bash_profile\033[39m"
	$(shell mv ~/.bash_profile ~/.bash_profile.bkp)
	ln -s $(pwd)/.bash_profile ~/.bash_profile

install_brew:
	./macos.brew.sh

clean:
	@echo -e "\n\033[32mRunning: clean\033[39m"
	unlink ~/.bash_profile
	touch ~/.bash_profile

	@for dir in $(config_dirs); do \
		if [ -L ~/.config/$$dir ]; then \
			echo "unlink ~/.config/$$dir"; \
			unlink ~/.config/$$dir; \
		fi \
	done

