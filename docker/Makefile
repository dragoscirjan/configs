## v0.4
#
# Detect OS
#
OSFLAG :=
OSARCH :=
OSID :=
ifeq ($(OS),Windows_NT)
	OSFLAG = WIN32
	ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
		OSARCH = AMD64
	endif
	ifeq ($(PROCESSOR_ARCHITECTURE),x86)
		OSARCH = IA32
	endif
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OSFLAG = LINUX
		OSID = $(shell cat /etc/*-release | egrep "^ID=" | cut -f2 -d=)
	endif
	ifeq ($(UNAME_S),Darwin)
		OSFLAG = OSX
	endif
		UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		OSARCH = AMD64
	endif
		ifneq ($(filter %86,$(UNAME_P)),)
			OSARCH = IA32
		endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		OSARCH = ARM
	endif
endif

#
# Detect Shell
#
SHELL_IS := 
ifeq ($(SHELL),/bin/bash)
    SHELL_IS = bash
else ifeq ($(SHELL),/usr/bin/bash)
    SHELL_IS = bash
else ifeq ($(SHELL),/bin/sh)
	SHELL_IS = bash
else ifeq ($(SHELL),C:/Program Files/Git/usr/bin/sh.exe)
	SHELL_IS = bash
else
    SHELL_IS = powershell
endif

#
# Help Directive
#
.PHONY: help
help:
ifeq ($(SHELL_IS),bash)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
else
	@echo 'Windows Help not available yet.'
endif
.DEFAULT_GOAL := help

#
# Binaries
#

POWERSHELL=powershell -ExecutionPolicy ByPass

#
# ENV
#

NOT_IMPLEMENTED_LINUX = "Not implemented under Linux"
NOT_IMPLEMENTED_OSX = "Not implemented under OSX"
NOT_IMPLEMENTED_WINDOWS = "Not implemented under Windows"

#
# Actual Action Definitions
#

mysql: ## Launch a MySQL Global Container
	docker run --name global-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=weltest -d mysql:5

mysql-e: ## Launch a MySQL 8 Global Container
	docker run --name global-mysql-8 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=weltest -d mysql:8

neo: ## Launch a Neo4j Global Container
	docker run --name global-neo4j -d -p7687:7687 -p7474:7474 -e NEO4J_AUTH=neo4j/weltest neo4j:latest

postgres: ## Launch a PostGresSQL§ 8 Global Container
	docker run --name global-postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=weltest postgres:alpine