include Makefile.template

#
# Actual Action Definitions
#


i: i-$(OSFLAG) ## Install Docker

i-LINUX:
	sudo curl -sL https://get.docker.com | bash

	sudo curl -L "https://github.com/docker/compose/releases/download/$$(curl -sLS https://github.com/docker/compose/releases | grep releases | grep tag | awk -F'>' '{print $$2}' | awk -F'<' '{print $$1}' | grep 1 | head -n1)/docker-compose-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

	sudo curl -L https://github.com/docker/machine/releases/download/$$(curl -sLS https://github.com/docker/machine/releases | grep releases | grep tag | awk -F'>' '{print $$2}' | awk -F'<' '{print $$1}' | grep 1 | head -n1)/docker-machine-`uname -s`-`uname -m` -o /usr/local/bin/docker-machine
	sudo chmod +x /usr/local/bin/docker-machine

i-OSX:
	echo $(NOT_IMPLEMENTED_OSX)

i-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


r-mysql: ## Launch a MySQL Global Container
	docker run --name global-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=weltest -d mysql:5

r-mysql-e: ## Launch a MySQL 8 Global Container
	docker run --name global-mysql-8 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=weltest -d mysql:8

r-neo: ## Launch a Neo4j Global Container
	docker run --name global-neo4j -d -p7687:7687 -p7474:7474 -e NEO4J_AUTH=neo4j/weltest neo4j:latest

r-postgres: ## Launch a PostGresSQL§ 8 Global Container
	docker run --name global-postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=weltest postgres:alpine

SWARM_ADVERTISE=$(shell ip addr show | grep -E "inet [0-9]" | grep -Ev " (lo|docker)" | head -n 1 | awk '{print $$2}' | awk -F'/' '{print $$1}')
SWARM_MASTER_ACTIVATE_ARGS=

sim_check:
	@echo "Activating Docker Swarm (Master). Advertise Address is: $(SWARM_ADVERTISE)."
	@read -r -p "Do you wish to continue? [N/y] " response && [ "$$response" = "y" ]

sim: sim_check ## Activate Docker Swarm as Master SWARM_ADVERTISE=0.0.0.0 SWARM_MASTER_ACTIVATE_ARGS=
	@sudo docker swarm init --advertise-addr $(SWARM_ADVERTISE) $(SWARM_MASTER_ACTIVATE_ARGS)

simw: ## Describe the Docker Swarm command for Worker to join the Master
	@sudo docker swarm join-token worker


siml: ## Destroy Docker Swarm Master
	@echo "Swarm's the shit, mate! Why 'ya wanna leave?"

siwl: ## Destroy Docker Swarm Worker
	sudo docker swarm leave -f
	@echo "Swarm's the shit, mate! Why 'ya wanna leave?"
