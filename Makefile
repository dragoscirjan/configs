include Makefile.template

all-help: all-help-$(SHELL_IS) ## List Help on all Config Folders

all-help-bash:
	@find . -mindepth 1 -maxdepth 1 -type d | while read d; do \
		test -f $$d/Makefile \
			&& echo "$$d" \
			&& make --directory=$$d; \
	done

all-help-powershell:
	@echo 'Windows Help not available yet.'

all: ide browsers ## Install all required tools

ide: ## Install Used IDEs
	make --directory=./ide atom idea-ce pycharm-ce sublime vscode
	make --directory=./git gitkraken

browsers: ## Install Used Browsers
	make --directory=./browsers chromium firefox edge opera vivaldi

office: ## Install Office Tools
	make --directory=./office libreoffice wpsoffice

terminal: ## Install Terminal Tools
	make --directory=./terminal conemu cmder iterm

CP_TEMPLATE=cp Makefile.template
sync-makefile-template:
	$(CP_TEMPLATE) ./.install
	$(CP_TEMPLATE) ./ide
	$(CP_TEMPLATE) ./router-assus
	$(CP_TEMPLATE) ./docker
	$(CP_TEMPLATE) ./bin
	$(CP_TEMPLATE) ./office
	$(CP_TEMPLATE) ./terminal
	$(CP_TEMPLATE) ./lang
	$(CP_TEMPLATE) ./browsers
	$(CP_TEMPLATE) ./fonts
	$(CP_TEMPLATE) ./code-templates
	$(CP_TEMPLATE) ./code-templates/swagger-generator
	$(CP_TEMPLATE) ./code-templates/php-symfony
	$(CP_TEMPLATE) ./code-templates/python
	$(CP_TEMPLATE) ./code-templates/typescript
	$(CP_TEMPLATE) ./git
	$(CP_TEMPLATE) ./quemu/macos
