.DEFAULT_GOAL := install

.PHONY: install

install:
	./_prep-env.sh
	./_install-apps.sh
	./_relink-config.sh
	./_relink-home.sh
	./_set-defaults.sh
	@echo "==> All done."
