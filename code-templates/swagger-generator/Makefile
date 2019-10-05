##
## v0.1
## @see https://github.com/dragoscirjan/template-swagger-generator
##
## Makefile Template v0.5
##

#
# Constants
#

SWAGGER_URL="http://central.maven.org/maven2/io/swagger/swagger-codegen-cli/2.4.8/swagger-codegen-cli-2.4.8.jar"
SWAGGER_JAR=swagger-codegen-cli.jar
SWAGGER_BIN=java -jar $(SWAGGER_JAR)

OPENAPI_URL="http://central.maven.org/maven2/org/openapitools/openapi-generator-cli/4.1.2/openapi-generator-cli-4.1.2.jar"
OPENAPI_JAR=openapi-generator-cli.jar
OPENAPI_BIN=java -jar $(OPENAPI_JAR)


PATH_SEPARATOR=:
ifeq ($(OS),Windows_NT)
	PATH_SEPARATOR=;
endif


# GENERATOR=openapi
GENERATOR=swagger

PROJECT=swagger-generator
PROJECT_VERSION=0.0.1
PROJECT_JAVA_PACKAGE_PREFIX:=com.custom
PROJECT_JAVA_PACKAGE=$(PROJECT_JAVA_PACKAGE_PREFIX).$(GENERATOR).codegen

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
# Binaries
#

POWERSHELL=powershell -ExecutionPolicy ByPass

#
# Help Directive
#
.PHONY: help
help:
ifeq ($(SHELL_IS),bash)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
else
	@$(POWERSHELL) "Select-String -Path $(MAKEFILE_LIST) -Pattern '^[a-zA-Z_-]+:.*?## .*$$' | Foreach-Object { $$tag = $$_.Matches[0].Value.split(':')[0]; $$explain = $$_.Matches[0].Value.split('#')[2]; Write-Host $$tag.PadRight(30, ' ') -ForegroundColor Cyan -NoNewline; Write-Host $$explain; }"
endif
.DEFAULT_GOAL := help

#
# Actual Action Definitions
#


build-generator: clean ## Build Generator
	mvn package


clean: ## Clean Undesired generated files
	rm -rf test


download: download-$(GENERATOR)

download-openapi:
	#
	# @see https://github.com/OpenAPITools/openapi-generator#13---download-jar~
	#
ifeq ($(SHELL_IS),bash)
	[ -f $(OPENAPI_JAR) ] || curl -SL $(OPENAPI_URL) -o $(OPENAPI_JAR) || wget $(OPENAPI_URL) -O $(OPENAPI_JAR)
else
	$(POWERSHELL) 'Invoke-WebRequest -OutFile $(OPENAPI_JAR) $(OPENAPI_URL)'
endif

download-swagger:
	# 
	# @see https://github.com/swagger-api/swagger-codegen/blob/master/README.md#prerequisites
	# 
ifeq ($(SHELL_IS),bash)
	[ -f $(SWAGGER_JAR) ] || curl -SL $(SWAGGER_URL) -o $(SWAGGER_JAR) || wget $(SWAGGER_URL) -O $(SWAGGER_JAR)
else
	$(POWERSHELL) 'Invoke-WebRequest -OutFile $(SWAGGER_JAR) $(SWAGGER_URL)
endif

generate: build generate-$(GENERATOR) ## Generate Code based on template

generate-openapi:
	# 
	# @see https://github.com/OpenAPITools/openapi-generator/blob/master/docs/customization.md#use-your-new-generator-with-the-cli
	# TODO: Edit accordingly
	# 
	java -cp "target/$(PROJECT)-swagger-codegen-$(PROJECT_VERSION).jar$(PATH_SEPARATOR)$(SWAGGER_JAR)" \
		org.openapitools.codegen.OpenAPIGenerator generate \
		-l $(PROJECT) \
		-i http://petstore.swagger.io/v2/swagger.json \
		-o test/petstore

generate-swagger:
	# 
	# @see https://github.com/swagger-api/swagger-codegen/blob/master/README.md#making-your-own-codegen-modules
	# TODO: Edit accordingly
	# 
	java -cp "target/$(PROJECT)-swagger-codegen-$(PROJECT_VERSION).jar$(PATH_SEPARATOR)$(SWAGGER_JAR)" \
		io.swagger.codegen.SwaggerCodegen generate \
		-l $(PROJECT) \
		-i http://petstore.swagger.io/v2/swagger.json \
		-o test/petstore


init-generator: download init-$(GENERATOR) ## Initialize Module (Do not use unless initializing project)

init-openapi:
	#
	# @see https://github.com/OpenAPITools/openapi-generator/blob/master/docs/customization.md#creating-a-new-template
	#
	$(OPENAPI_BIN) meta -o . -n $(PROJECT) -p $(PROJECT_JAVA_PACKAGE)

init-swagger:
	# 
	# @see https://github.com/swagger-api/swagger-codegen/blob/master/README.md#making-your-own-codegen-modules
	# 
	$(SWAGGER_BIN) meta -o . -n $(PROJECT) -p $(PROJECT_JAVA_PACKAGE)


test-generator: test-$(GENERATOR) ## Test Generated Content

test-openapi:
	# 
	# @see https://github.com/OpenAPITools/openapi-generator/blob/master/docs/customization.md#use-your-new-generator-with-the-cli
	# 
	java -cp "target/$(PROJECT)-swagger-codegen-$(PROJECT_VERSION).jar$(PATH_SEPARATOR)$(SWAGGER_JAR)" \
		org.openapitools.codegen.OpenAPIGenerator generate \
		-l $(PROJECT) \
		-i http://petstore.swagger.io/v2/swagger.json \
		-o test/petstore

test-swagger:
	# 
	# @see https://github.com/swagger-api/swagger-codegen/blob/master/README.md#making-your-own-codegen-modules
	# 
	java -cp "target/$(PROJECT)-swagger-codegen-$(PROJECT_VERSION).jar$(PATH_SEPARATOR)$(SWAGGER_JAR)" \
		io.swagger.codegen.SwaggerCodegen generate \
		-l $(PROJECT) \
		-i http://petstore.swagger.io/v2/swagger.json \
		-o test/petstore


