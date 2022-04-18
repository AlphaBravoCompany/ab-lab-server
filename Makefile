
include tools/makefiles/content/Makefile
include tools/makefiles/content/do/Makefile
include tools/makefiles/content/aws-spot/Makefile
include tools/makefiles/content/aws/Makefile
include tools/makefiles/deployment/Makefile
include tools/makefiles/docker/Makefile
include tools/makefiles/misc/Makefile

.PHONY: help
.DEFAULT_GOAL := help
SHELL ?= /usr/bin/zsh

COLOR_GREEN=$(shell echo "\033[0;32m")
COLOR_RED=$(shell echo "\033[0;31m")
COLOR_END=$(shell echo "\033[0;0m")

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
FILE_PATH := $(realpath $(dir $(MAKEFILE_PATH)))

COMPOSE_EXEC ?= docker-compose exec
DEV_NAME = development
DEV_EXEC = $(COMPOSE_EXEC) $(DEV_NAME)
REGISTRY = ghcr.io/alphabravocompany
LOCAL_TAG = test
REMOTE_TAG = latest

KUBECONFIG = "ansible/files/$(BRANCH)/kubeconfig/config"
KUBE = kubectl --kubeconfig=$(KUBECONFIG)

BRANCH := $(shell git rev-parse --abbrev-ref HEAD | tr '[:upper:]' '[:lower:]')
UNAME := $(shell uname -s | tr '[:upper:]' '[:lower:]')
VARIABLES_FILE = variables.yml
SECRETS_FILE = secrets.yml
GET_DATE := $(shell date +%FT%T%Z)
CERT_DATE := $(shell date +%Y%m%d)
BUFFER_ITERATIONS = 6
BUFFER_SLEEP = 10



## ---
## HELP - SHOWS A LIST OF AVAILABLE TARGETS WHICH CAN BE CALLED WITH MAKE.
## ---

help:
	@for makefile in $(MAKEFILE_LIST) ; do \
		grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $$makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' ; \
	done


## ---
## A LIST OF STAGES TO OPERATE IN ORDER FOR DO. NOT SHOWN IN MAKE LIST.
## ---

test: generate-folder populate-vars

stage-1-do: generate-folder-do populate-vars stage-2

stage-2: terraform-deploy pause-buffer stage-3

stage-3: ansible-deploy

## ---
## A LIST OF STAGES TO OPERATE IN ORDER FOR AWS SPOT. NOT SHOWN IN MAKE LIST.
## ---

stage-1-aws-spot: generate-folder-aws-spot populate-vars stage-2

## ---
## A LIST OF STAGES TO OPERATE IN ORDER FOR AWS SPOT. NOT SHOWN IN MAKE LIST.
## ---

stage-1-aws: generate-folder-aws populate-vars stage-2


## --
## CALL MULTIPLE TARGETS FROM A SINGLE CALL
## ---

setup-do: stage-1-do ## Runs a full, end-to-end deployment with infrastructure, K8s, and umbrella.
	@echo "$(COLOR_GREEN)\n--- Setup completed.$(COLOR_END)"

setup-aws-spot: stage-1-aws-spot ## Runs a full, end-to-end deployment with infrastructure, K8s, and umbrella.
	@echo "$(COLOR_GREEN)\n--- Setup completed.$(COLOR_END)"

setup-aws: stage-1-aws ## Runs a full, end-to-end deployment with infrastructure, K8s, and umbrella.
	@echo "$(COLOR_GREEN)\n--- Setup completed.$(COLOR_END)"

teardown: terraform-kaboom cleanup-folders ## Runs all cleanup and teardown commands. WARNING: Permanent deletion!
	@echo "$(COLOR_GREEN)\n--- Teardown completed.$(COLOR_END)"

environment: docker-pull docker-up docker-shell ## Brings up a development environment with all required dependencies.

env: environment ## Because I don't want to type the whole work environment

k3d:
	@ansible-playbook -i ansible/inventory/$(BRANCH)/$(BRANCH)-inventory ansible/main.yml  --tags  "k3d"