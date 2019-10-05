include ./Makefile.template

#
# Constants (Overrides)
#

PROJECT=makefile
PROJECT_VERSION=0.0.1

#
# Actual Action Definitions
#

init: ## Initialize a new Symfony Project (within Makefile folder)
	# [ -f Makefile.template ] || curl -sSL https://raw.githubusercontent.com/dragoscirjan/template-makefile/master/Makefile.template > Makefile.template
	composer create-project symfony/skeleton .
	

link-assets: ## Link CSS & JavaScript
	php app/console assets:install web --symlink || php bin/console assets:install web --symlink

build: ## Build code

clean: docker-clean ## Clean built code and any other unnecesary folders
	composer cache:clear
	# for Symfony 2 & 3
	rm -rf app/cache/* 

docker-clean: ## Clean Docker Images
	docker images -a

docker-build: clean ## Build Docker Image
	docker build -t $(PROJECT):$(PROJECT_VERSION)
	docker build -t $(PROJECT):latest
