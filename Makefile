.PHONY: help

help: ## display help message
	@echo "Please user 'make <target>' where <target> is one of"
	@perl -nle'print $& if m{^[\.a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'

install: ## Install requirements
	pip install -r requirements.txt
	cd exam-frontend && npm i

dev.makemigrations: ## Generate migrations
	python manage.py makemigrations exam_paper

dev.migrate: ## Execute migrate
	python manage.py migrate

dev.build: ## build react app
	cd exam-frontend && npm run build

dev.up: ## Run develop server
	python manage.py runserver 0.0.0.0:8111

dev.update: | install dev.makemigrations dev.migrate dev.build ## update server

