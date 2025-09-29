.PHONY: update

update:
	@echo "updating"
	@./_relink-config.sh
	@./_relink-home.sh
