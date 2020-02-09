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

sm_check:
	@echo "Activating Docker Swarm (Master). Advertise Address is: $(SWARM_ADVERTISE)."
	@read -r -p "Do you wish to continue? [N/y] " response && [ "$$response" = "y" ]

sm: sim_check ## Activate Docker Swarm as Master SWARM_ADVERTISE=0.0.0.0 SWARM_MASTER_ACTIVATE_ARGS=
	@sudo docker swarm init --advertise-addr $(SWARM_ADVERTISE) $(SWARM_MASTER_ACTIVATE_ARGS)

smj: ## Describe the Docker Swarm command for Worker to join the Master
	@sudo docker swarm join-token worker


sml: ## Destroy Docker Swarm Master
	@echo "Swarm's the shit, mate! Why 'ya wanna leave?"

swl: ## Destroy Docker Swarm Worker
	sudo docker swarm leave -f
	@echo "Swarm's the shit, mate! Why 'ya wanna leave?"

ki: ki-$(OSFLAG) ## Install Kubernetes KubeAdm, KubeCtl
	kubeadm version
	kubectl version

ki-LINUX: ki-$(OSID)

ki-debian:
	sudo apt-get update && sudo apt-get install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubeadm kubectl

ki-ubuntu: ki-debian

ki-fedora: ki-redhat

ki-redhat:
	cat <<EOF > /etc/yum.repos.d/kubernetes.repo
	[kubernetes]
	name=Kubernetes
	baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
	enabled=1
	gpgcheck=1
	repo_gpgcheck=1
	gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
	EOF
	yum install -y kubectl

ki-LINUX-snap:
	snap install kubectl --classic

ki-OSX:
	echo $(NOT_IMPLEMENTED_OSX)

ki-WIN32:
	echo $(NOT_IMPLEMENTED_WINDOWS)


KUBE_ADVERTISE=$(shell ip addr show | grep -E "inet [0-9]" | grep -Ev " (lo|docker)" | head -n 1 | awk '{print $$2}')
KUBE_MASTER_ACTIVATE_ARGS=

km_check:
	@echo "Activating Kubernetes (Master). Advertise Address is: $(KUBE_ADVERTISE)."
	@read -r -p "Do you wish to continue? [N/y] " response && [ "$$response" = "y" ]

km: km_check ## Activate Kubernetes as Master KUBE_ADVERTISE=? KUBE_MASTER_ACTIVATE_ARGS=?
	# https://vitux.com/install-and-deploy-kubernetes-on-ubuntu/
	sudo swapoff -a
	sudo kubeadm init --pod-network-cidr=$(KUBE_ADVERTISE) $(KUBE_MASTER_ACTIVATE_ARGS)

kmc: ## Configure Kubernetes Master server
	mkdir -p $$HOME/.kube
	sudo cp -i /etc/kubernetes/admin.conf $$HOME/.kube/config
	sudo chown $(shell id -u):$(shell id -g) $$HOME/.kube/config

KUBE_JOIN_TOKEN=$(shell sudo kubeadm token list --skip-headers | grep -E "[1-9][0-9]?h" | awk '{print $1}' | head -n 1)
KUBE_JOIN_HASH=$(shell openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')
KUBE_JOIN_ADDR=$(shell ip addr show | grep -E "inet [0-9]" | grep -Ev " (lo|docker)" | head -n 1 | awk '{print $$2}' | awk -F'/' '{print $$1}')

kmj:
	# https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-join/
ifneq ($(KUBE_JOIN_TOKEN),)
	@echo "kubeadm join --discovery-token $(KUBE_JOIN_TOKEN) --discovery-token-ca-cert-hash $(KUBE_JOIN_HASH) $(KUBE_JOIN_ADDR):6443"
else
	@kubeadm token create --print-join-command
endif
