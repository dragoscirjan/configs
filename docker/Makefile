include ../Makefile.template

#
# Actual Action Definitions
#

install: install--$(OSFLAG) ## Install Docker

install--LINUX:
	cd ../linux/curl && make install
	curl -sSL https://get.docker.com | sudo bash

	base="https://github.com/docker/compose/releases/download/1.29.1" \
	&& sudo curl -L "$$base/docker-compose-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-compose \
	&& sudo chmod +x /usr/local/bin/docker-compose

	base=https://github.com/docker/machine/releases/download/v0.16.0 \
	&& sudo curl -L "$$base/docker-machine-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-machine \
	&& sudo chmod +x /usr/local/bin/docker-machine


install--OSX:
	@echo TODO:

install--WIN32:
	@echo TODO:

uninstall: uninstall--$(OSFLAG) ## Uninstall Docker

uninstall--LINUX:
	which docker && \
	$(PACKAGE_REMOVE) $$(dpkg -l | grep docker | awk -F' ' '{ print $$2 }')

	which docker-compose && sudo rm -rf /usr/local/bin/docker-compose
	which docker-machine && sudo rm -rf /usr/local/bin/docker-machine

uninstall--OSX:
	@echo TODO:

uninstall--WIN32:
	@echo TODO:


test: ## Test Docker
	sudo docker run hello-world

# APTGET = sudo apt-get

# i: i-$(OSFLAG) ## Install Docker

# i-LINUX: rootcheck  i-$(OSID)
# 	curl -sL https://get.docker.com | bash

# 	bash ./scripts/docker-config.sh

# 	systemctl daemon-reload
# 	systemctl restart docker

# 	docker --version
# 	sleep 5

# 	curl -L "https://github.com/docker/compose/releases/download/$$(curl -sLS https://github.com/docker/compose/releases | grep releases | grep tag | awk -F'>' '{print $$2}' | awk -F'<' '{print $$1}' | grep 1 | head -n1)/docker-compose-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-compose
# 	sudo chmod +x /usr/local/bin/docker-compose

# 	docker-compose --version
# 	sleep 5

# 	curl -L https://github.com/docker/machine/releases/download/$$(curl -sLS https://github.com/docker/machine/releases | grep releases | grep tag | awk -F'>' '{print $$2}' | awk -F'<' '{print $$1}' | grep 1 | head -n1)/docker-machine-`uname -s`-`uname -m` -o /usr/local/bin/docker-machine
# 	sudo chmod +x /usr/local/bin/docker-machine

# 	docker-machine --version

# i-debian:
# 	apt-get update
# 	apt-get install -y curl

# i-ubuntu: i-debian

# i-OSX:
# 	echo $(NOT_IMPLEMENTED_OSX)

# i-WIN32:
# 	echo $(NOT_IMPLEMENTED_WINDOWS)


# r-mysql: ## Launch a MySQL Global Container
# 	docker run --name global-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=weltest -d mysql:5

# r-mysql-e: ## Launch a MySQL 8 Global Container
# 	docker run --name global-mysql-8 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=weltest -d mysql:8

# r-neo: ## Launch a Neo4j Global Container
# 	docker run --name global-neo4j -d -p7687:7687 -p7474:7474 -e NEO4J_AUTH=neo4j/weltest neo4j:latest

# r-postgres: ## Launch a PostGresSQL§ 8 Global Container
# 	docker run --name global-postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=weltest postgres:alpine

# # r-registry: ## Launch Local Registry
# # 	docker run --entrypoint htpasswd registry:2 -Bbn admin weltest > $$HOME/.docker-registry-password
# # 	mkdir -p $$HOME/.docker_cert
# # 	openssl req \
# # 		-newkey rsa:4096 -nodes -sha256 -keyout $$HOME/.docker_cert/cert.key \
# # 		-x509 -days 365 -out $$HOME/.docker_cert/cert.crt
# # 	docker run -d \
# # 		-e REGISTRY_HTTP_ADDR=0.0.0.0:5000 \
# # 		-e "REGISTRY_AUTH=htpasswd" \
# # 		-e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
# # 		-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
# # 		-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/cert.crt \
# # 		-e REGISTRY_HTTP_TLS_KEY=/certs/cert.key \
# # 		-p 5000:5000 \
# # 		-v $HOME/.docker-registry-password:/auth/htpasswd \
# # 		-v $HOME/.docker_cert:/certs \
# # 		--restart=always \
# # 		--name registry \
# # 		registry:2

# SWARM_ADVERTISE=$(shell ip addr show | grep -E "inet [0-9]" | grep -Ev " (lo|docker)" | head -n 1 | awk '{print $$2}' | awk -F'/' '{print $$1}')
# SWARM_MASTER_ACTIVATE_ARGS=

# sm_check:
# 	@echo "Activating Docker Swarm (Master). Advertise Address is: $(SWARM_ADVERTISE)."
# 	@read -r -p "Do you wish to continue? [N/y] " response && [ "$$response" = "y" ]

# sm: sim_check ## Activate Docker Swarm as Master SWARM_ADVERTISE=0.0.0.0 SWARM_MASTER_ACTIVATE_ARGS=
# 	@sudo docker swarm init --advertise-addr $(SWARM_ADVERTISE) $(SWARM_MASTER_ACTIVATE_ARGS)

# smj: ## Describe the Docker Swarm command for Worker to join the Master
# 	@sudo docker swarm join-token worker


# sml: ## Destroy Docker Swarm Master
# 	@echo "Swarm's the shit, mate! Why 'ya wanna leave?"

# swl: ## Destroy Docker Swarm Worker
# 	sudo docker swarm leave -f
# 	@echo "Swarm's the shit, mate! Why 'ya wanna leave?"

# k8si: rootcheck k8si-$(OSFLAG) ## Install Kubernetes KubeAdm, KubeCtl, KubeLet

# k8si-LINUX: k8si-$(OSID)

# k8si-debian:
# 	$(APTGET) update
# 	$(APTGET) install -y apt-transport-https

# 	$(APTGET) update && sudo apt-get install -y apt-transport-https curl
# 	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | $(APTGET) add - || true
# 	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
# 	$(APTGET) update
# 	$(APTGET) install -y kubelet kubeadm kubectl

# k8si-ubuntu: k8si-debian

# k8si-fedora: k8si-redhat

# k8si-redhat:
# 	cat <<EOF > /etc/yum.repos.d/kubernetes.repo
# 	[kubernetes]
# 	name=Kubernetes
# 	baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
# 	enabled=1
# 	gpgcheck=1
# 	repo_gpgcheck=1
# 	gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
# 	EOF
# 	yum install -y kubeadm

# k8si-OSX:
# 	echo $(NOT_IMPLEMENTED_OSX)

# k8si-WIN32:
# 	echo $(NOT_IMPLEMENTED_WINDOWS)


# k8sc: ## Configure Kubernetes Master (standalone)
# 	make k8sc1_init
# 	make k8sc2_user
# 	make k8sc3_network

# KUBE_POD_NETWORK_ADDR = 10.244.0.0/16
# KUBE_POD_NETWORK_TYPE = flannel

# k8sc1_init: norootcheck ## (1) Configure Kubernetes Mastert => init ... :: KUBE_POD_NETWORK_ADDR=10.244.0.0/16
# 	sudo swapoff -a
# 	sudo kubeadm init --pod-network-cidr=$(KUBE_POD_NETWORK_ADDR)

# 	sleep 10
# 	kubectl get all --all-namespaces -o wide

# k8sc2_user: norootcheck ## (2) Configure Kubernetes Mastert => configure user
# 	sudo rm -rf $$HOME/.kube* || true
# 	mkdir -p $$HOME/.kube
# 	sudo cp -i /etc/kubernetes/admin.conf $$HOME/.kube/config
# 	sudo chown $$(id -u):$$(id -g) $$HOME/.kube/config

# k8sc3_network: norootcheck ## (3) Configure Kubernetes Mastert => deploy network KUBE_POD_NETWORK_TYPE=flannel
# 	# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network
# ifeq ($(KUBE_POD_NETWORK_TYPE), flannel)
# 	sudo sysctl net.bridge.bridge-nf-call-iptables=1
# 	kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml
# else
# ifeq ($(KUBE_POD_NETWORK_TYPE), calico)
# 	# https://docs.projectcalico.org/v3.0/getting-started/kubernetes/
# 	kubectl apply -f kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml
# else
# 	kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$$(kubectl version | base64 | tr -d '\n')"
# endif
# endif

# k8sc4_dashboard: norootcheck ## (4) Configure Kubernetes Mastert => (optional) dashboard
# 	sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc5/aio/deploy/recommended.yaml
# 	sleep 10
# 	sudo kubectl create serviceaccount dashboard -n kubernetes-dashboard
# 	sudo kubectl create clusterrolebinding dasboard-admin -n default --clusterrole=cluster-admin --serviceaccount=default:dashboard
# 	sudo kubectl get secret $$(kubectl get serviceaccount default -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
# 	sleep 5
# 	@echo
# 	@echo "Use 'kubectl proxy --address=<ip>' to view dashboard"
# 	@echo

# k8sc5_usemaster: norootcheck ## (5) Configure Kubernetes Mastert => (optional) (don't use in prod) enable pods creation on master
# 	kubectl taint nodes --all node-role.kubernetes.io/master-

# k8sj: ## Configure Kubernetes Slave :: Generate Join Command
# 	kubeadm token create --print-join-command

# k8sr: norootcheck ## Reset Kubernetes Master
# 	sudo kubeadm reset
# 	sudo rm -rf $$HOME/.kube* || true
# 	sudo rm -rf /etc/kubernetes

# k8sui: norootcheck ## Uninstall Kubernetes
# 	$(APTGET) remove -y kubelet kubeadm kubectl


# mk8si: mk8si-$(OSFLAG) ## Install Kubernetes microk8s :: KubeAdm, KubeCtl, KubeLet

# mk8si-LINUX:
# 	sudo snap install microk8s --classic --channel=1.18/stable
# 	sudo usermod -a -G microk8s $$USER
# 	@echo "Run `make mkc` after user change."
# 	su - $$USER

# mk8si-OSX:
# 	echo $(NOT_IMPLEMENTED_OSX)

# mk8si-WIN32:
# 	echo $(NOT_IMPLEMENTED_WINDOWS)

# mk8sc: ## Configure Kubernetes Master (microk8s)
# 	microk8s status --wait-ready

# 	sudo rm -rf $$HOME/.kube* || true
# 	sudo mkdir -p $$HOME/.kube
# 	microk8s.kubectl config view --raw > $$HOME/.kube/config

# 	sudo microk8s enable dns dashboard registry
# 	sudo snap alias microk8s.kubectl kubectl

# 	kubectl get all --all-namespaces

# mk8sj: ## Configure Kubernetes Slave (microk8s) :: Generate Join Command
# 	microk8s.kubeadm token create --print-join-command
