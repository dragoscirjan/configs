include Makefile.template

#
# Actual Action Definitions
#

LXC_UNPRIV_USER = $(shell whoami)
LXC_USERNET_CONFIG = /etc/lxc/lxc-usernet

lxci: lxci-$(OSFLAG) ## Install LXC

lxci-LINUX: norootcheck  i-$(OSID)
	
lxci-debian:
	$(APTGET) install -y lxc lxc-templates

lxci-ubuntu: lxci-debian

lxc-unprivileged: norootcheck ## LXC => Configure Unprivileged Containers LXC_UNPRIV_USER=$$(whoami)
	@# https://www.cyberciti.biz/faq/how-to-create-unprivileged-linux-containers-on-ubuntu-linux/
	grep $(LXC_UNPRIV_USER)	$(LXC_USERNET_CONFIG) || sudo bash -c 'echo "$(LXC_UNPRIV_USER) veth lxcbr0 10" >> $(LXC_USERNET_CONFIG)'
	
	rm -rf ~/.config/lxc || true
	mkdir -p ~/.config/lxc
	cp /etc/lxc/default.conf ~/.config/lxc/default.conf

	@# NOTE: lxc.id_map is now lxc.idmap
	echo "lxc.idmap = u 0 $$(grep $(LXC_UNPRIV_USER) /etc/subuid | awk -F ':' '{ print $$2,$$3}')" >> ~/.config/lxc/default.conf
	echo "lxc.idmap = g 0 $$(grep $(LXC_UNPRIV_USER) /etc/subgid | awk -F ':' '{ print $$2,$$3}')" >> ~/.config/lxc/default.conf