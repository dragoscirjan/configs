include ../../../Makefile.template

#
# Actual Action Definitions
#

install: ## Install Docker
	sudo apt install -y docker docker.io

	base="https://github.com/docker/compose/releases/download/1.29.1" \
	&& sudo curl -L "$$base/docker-compose-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-compose \
	&& sudo chmod +x /usr/local/bin/docker-compose

	base=https://github.com/docker/machine/releases/download/v0.16.0 \
	&& sudo curl -L "$$base/docker-machine-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-machine \
	&& sudo chmod +x /usr/local/bin/docker-machine

uninstall: ## Uninstall Docker
	which docker && \
	DOCKER_PACKAGES=$$(dpkg -l | grep docker | awk -F' ' '{ print $$2 }') && \
	echo $$DOCKER_PACKAGES && \
	sudo apt remove --purge $$DOCKER_PACKAGES

	which docker-compose && sudo rm -rf /usr/local/bin/docker-compose
	which docker-machine && sudo rm -rf /usr/local/bin/docker-machine

test: ## Test Docker
	sudo docker run hello-world
