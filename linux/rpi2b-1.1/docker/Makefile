include ../../../Makefile.template

#
# Actual Action Definitions
#

install: ## Install Docker
	which docker || \
	sudo apt install -y docker docker.io docker-compose

uninstall: ## Uninstall Docker
	which docker && \
	DOCKER_PACKAGES=$$(dpkg -l | grep docker | awk -F' ' '{ print $$2 }') && \
	echo $$DOCKER_PACKAGES && \
	sudo apt remove --purge $$DOCKER_PACKAGES

test: ## Test Docker
	sudo docker run hello-world
