#
# Detect OS
#
OSFLAG :=
OSBASE :=
OSARCH :=
ifeq ($(OS),Windows_NT)
	OSFLAG = WIN32
	OSBASE = WIN
	ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
		OSARCH = AMD64
	endif
	ifeq ($(PROCESSOR_ARCHITECTURE),x86)
		OSARCH = IA32
	endif
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OSFLAG = LINUX
		OSBASE = NIX
	endif
	ifeq ($(UNAME_S),Darwin)
		OSFLAG = OSX
		OSBASE = NIX
	endif
		UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		OSARCH = AMD64
	endif
		ifneq ($(filter %86,$(UNAME_P)),)
			OSARCH = IA32
		endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		OSARCH = ARM
	endif
endif

#
# Detect Shell
#
SHELL_IS := 
ifeq ($(SHELL),/bin/bash)
    SHELL_IS = bash
else ifeq ($(SHELL),/bin/sh)
	SHELL_IS = bash
else
    SHELL_IS = powershell
endif

#
# Help Directive
#
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help

#
# Actual Action Definitions
#

SYM_APP := bin/console
ifneq (ok,$(test -f app/console && echo ok))
	# support for older versions of symfony
	SYM_APP := app/console
endif

cc: ## Clear Cache
	php $(SYM_APP) cache:clear --env=dev --no-warmup
	php $(SYM_APP) cache:clear --env=prod --no-warmup

cch: cc ## Clear Cache Hard
	rm -rf app/cache/*

ccw: cc ## Clear Cache with Warmup
	php $(SYM_APP) cache:warmupcd

composer: ## Install Composer
ifeq (NIX,$(OSBASE))
	ifeq (root,$(shell whoami))
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php --install-dir=/usr/local/bin --filename=composer
	php -r "unlink('composer-setup.php');"
	else
	@echo 'You need root privliedges to install composer to /usr/local/bin'
	endif
else
	@echo 'This feature is not implemented yet.'
endif

COMPOSER_INSTALL_ARGS ?=
i: ## composer install --no-dev
	composer install --no-dev $(COMPOSER_INSTALL_ARGS)

ind: ## composer install
	composer install $(COMPOSER_INSTALL_ARGS)

u: ## composer update
	composer update