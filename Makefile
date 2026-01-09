.DEFAULT_GOAL := help
SHELL := /bin/bash

ARGS :=
ifeq (,$(filter --,$(MAKECMDGOALS)))
else
ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
endif

GREEN  := \033[0;32m
CYAN   := \033[0;36m
RESET  := \033[0m

.PHONY: help
help: ## Show this help with available make targets
	@echo -e "$(CYAN)Available targets:$(RESET)\n"
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS=":.*##"} \
	{printf "  $(GREEN)%-20s$(RESET) %s\n", $$1, $$2}'

.PHONY: test
test: ## Run full test pipeline via script
	cp settings/test_local.py django/tests
	django/tests/runtests.py --settings test_local $(ARGS)
	rm -rf django/tests/test_local.py

-%:
	@:
