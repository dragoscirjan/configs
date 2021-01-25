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

<<<<<<< HEAD
CP_TEMPLATE=cp Makefile.template
sync-makefile-template:
	find . -mindepth 2 -iname "Makefile.template" | while read f; do cp Makefile.template $$f; done
=======
sync-template: sync-template-$(SHELL_IS)

# sync-template-bash:

sync-template-powershell:
	$(POWERSHELL) -Command '$$mainTemplate = (Get-Location); \
		$$mainTemplate = "$$MainTemplate\Makefile.template"; \
		Get-Childitem -Path . -Include *Makefile.template* -File -Recurse -ErrorAction SilentlyContinue | ForEach-Object { \
			if ($$mainTemplate -ne $$_.FullName) { Copy-Item -Path $$mainTemplate -Destination $$_.FullName -Force } \
		}'

>>>>>>> 8ae4156b993b609ff6937058db1defdbcdb6ae42
