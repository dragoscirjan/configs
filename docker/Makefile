include Makefile.template

#
# Actual Action Definitions
#

_root_check:
	@echo "Need root to run Kubernetes Install." && [ "$$(whoami)" = "root" ]

i: i-$(OSFLAG) ## Install Docker

i-LINUX: _root_check  i-$(OSID)
	curl -sL https://get.docker.com | bash

	# bash ./scripts/docker-config.sh

	# mkdir -p /etc/systemd/system/docker.service.d

	systemctl daemon-reload
	systemctl restart docker

	docker --version
	sleep 5

	curl -L "https://github.com/docker/compose/releases/download/$$(curl -sLS https://github.com/docker/compose/releases | grep releases | grep tag | awk -F'>' '{print $$2}' | awk -F'<' '{print $$1}' | grep 1 | head -n1)/docker-compose-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

	docker-compose --version
	sleep 5

	curl -L https://github.com/docker/machine/releases/download/$$(curl -sLS https://github.com/docker/machine/releases | grep releases | grep tag | awk -F'>' '{print $$2}' | awk -F'<' '{print $$1}' | grep 1 | head -n1)/docker-machine-`uname -s`-`uname -m` -o /usr/local/bin/docker-machine
	sudo chmod +x /usr/local/bin/docker-machine

	docker-machine --version

i-debian:
	apt-get update
	apt-get install -y curl

i-ubuntu: i-debian

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

# r-registry: ## Launch Local Registry
# 	docker run --entrypoint htpasswd registry:2 -Bbn admin weltest > $$HOME/.docker-registry-password
# 	mkdir -p $$HOME/.docker_cert
# 	openssl req \
# 		-newkey rsa:4096 -nodes -sha256 -keyout $$HOME/.docker_cert/cert.key \
# 		-x509 -days 365 -out $$HOME/.docker_cert/cert.crt
# 	docker run -d \
# 		-e REGISTRY_HTTP_ADDR=0.0.0.0:5000 \
# 		-e "REGISTRY_AUTH=htpasswd" \
# 		-e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
# 		-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
# 		-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/cert.crt \
# 		-e REGISTRY_HTTP_TLS_KEY=/certs/cert.key \
# 		-p 5000:5000 \
# 		-v $HOME/.docker-registry-password:/auth/htpasswd \
# 		-v $HOME/.docker_cert:/certs \
# 		--restart=always \
# 		--name registry \
# 		registry:2

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

ki: ki-$(OSFLAG) ## Install Kubernetes KubeAdm, KubeCtl, KubeLet

ki-LINUX: _root_check ki-$(OSID)

ki-debian:
	# When migrating to Debian 10 or Ubuntu 19+, take a look here:
	# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#ensure-iptables-tooling-does-not-use-the-nftables-backend

	# bash ./scripts/docker-config.sh
	sudo swapoff -a

	@# https://www.youtube.com/watch?v=UWg3ORRRF60&t=604s
	apt-get update 
	apt-get install -y apt-transport-https

	apt-get update && sudo apt-get install -y apt-transport-https curl
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubelet kubeadm kubectl
	sudo apt-mark hold kubelet kubeadm kubectl

	systemctl daemon-reload
	systemctl restart kubelet
	
	# sed '/Environment=[^\n]*/,$$!b;//{x;//p;g};//!H;$$!d;x;s//&\nEnvironment="cgroup-driver=systemd\/cgroup-driver=cgroupfs"/' -i /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

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


KUBE_ADVERTISE=$(shell ip addr show | grep -E "inet [0-9]" | grep -Ev " (lo|docker)" | head -n 1 | awk '{print $$2}' | awk -F'/' '{print $$1}')
KUBE_POD_NETWORK_TYPE=flannel
KUBE_POD_NETWORK_ADDR=172.168.10.0/16 # Use for Flanel
# KUBE_POD_NETWORK_ADDR=10.244.0.0/16 # Use for Flanel
# KUBE_POD_NETWORK_TYPE=calico
# KUBE_POD_NETWORKADDR=192.168.0.0/16 # Use for Calico
KUBE_MASTER_ACTIVATE_ARGS=

km_check:
	@echo "Activating Kubernetes (Master). Advertise Address is: $(KUBE_ADVERTISE)."
	@read -r -p "Do you wish to continue? [N/y] " response && [ "$$response" = "y" ]

km: km_check ## (1) Activate Kubernetes as Master :: KUBE_ADVERTISE=? KUBE_MASTER_ACTIVATE_ARGS=? KUBE_POD_NETWORK_TYPE=flannel KUBE_POD_NETWORK_ADDR=10.244.0.0/16
	# https://vitux.com/install-and-deploy-kubernetes-on-ubuntu/
	# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
	sudo swapoff -a
	sudo kubeadm init --pod-network-cidr=$(KUBE_POD_NETWORK_ADDR) --apiserver-advertise-address=$(KUBE_ADVERTISE) $(KUBE_MASTER_ACTIVATE_ARGS)

kmc: ## (2) Configure Kubernetes Master server
	mkdir -p $$HOME/.kube
	sudo cp -i /etc/kubernetes/admin.conf $$HOME/.kube/config
	sudo chown $(shell id -u):$(shell id -g) $$HOME/.kube/config

kmn: ## (3) Configure Kubernetes Network :: KUBE_POD_NETWORK_TYPE=flannel KUBE_POD_NETWORK_ADDR=10.244.0.0/16
ifeq ($(KUBE_POD_NETWORK_TYPE), flannel)
	sudo sysctl net.bridge.bridge-nf-call-iptables=1
	kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml
else
ifeq ($(KUBE_POD_NETWORK_TYPE), calico)
	# https://docs.projectcalico.org/v3.0/getting-started/kubernetes/
	kubectl apply -f https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml
else
	@echo "No network supported."
endif
endif

kmd: ## (4) Configure Kubernetes Dashboard :: KUBE_ADVERTISE=?
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc5/aio/deploy/recommended.yaml
	sleep 10
	kubectl create serviceaccount dashboard -n kubernetes-dashboard
	kubectl create clusterrolebinding dasboard-admin -n default --clusterrole=cluster-admin --serviceaccount=default:dashboard
	kubectl get secret $$(kubectl get serviceaccount default -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
	sleep 5
	kubectl proxy --address='$(KUBE_ADVERTISE)'

# kmj:
# 	@# https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-join/
# ifneq ($(shell sudo kubeadm token list --skip-headers | grep -E "[1-9][0-9]?h" | awk '{print $$1}' | head -n 1),)
# 	@echo "kubeadm join \
# 		--discovery-token $(shell sudo kubeadm token list --skip-headers | grep -E "[1-9][0-9]?h" | awk '{print $$1}' | head -n 1) \
# 		--discovery-token-ca-cert-hash $(shell openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //') $(shell ip addr show | grep -E "inet [0-9]" | grep -Ev " (lo|docker)" | head -n 1 | awk '{print $$2}' | awk -F'/' '{print $$1}'):6443"
# else
# 	@kubeadm token create --print-join-command
# endif
