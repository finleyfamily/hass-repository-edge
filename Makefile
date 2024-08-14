CI := $(if $(CI),yes,no)
SHELL := /bin/bash

ifeq ($(CI), yes)
	POETRY_OPTS = "-v"
	PRE_COMMIT_OPTS = --show-diff-on-failure --verbose
endif

fix: run-pre-commit ## run all automatic fixes

fix-md: ## automatically fix markdown format errors
	@poetry run pre-commit run mdformat --all-files

lint: ## run all linters
	@echo "no linters configured for this project"

run-pre-commit: ## run pre-commit for all files
	@poetry run pre-commit run $(PRE_COMMIT_OPTS) \
		--all-files \
		--color always

setup: setup-poetry setup-pre-commit setup-npm ## setup dev environment

setup-npm: ## install node dependencies with npm
	@npm ci

setup-poetry: ## setup python virtual environment
	@poetry check
	@poetry install $(POETRY_OPTS) --sync

setup-pre-commit: ## install pre-commit git hooks
	@poetry run pre-commit install

spellcheck: ## run cspell
	@echo "Running cSpell to checking spelling..."
	@npm exec --no -- cspell lint . \
		--color \
		--config .vscode/cspell.json \
		--dot \
		--gitignore \
		--must-find-files \
		--no-progress \
		--relative \
		--show-context

test: ## run tests
	@echo "no tests configured for this project"
