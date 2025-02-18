.ONESHELL:
.PHONY: docs
.DEFAULT_GOAL: all

DEV=1
TAG=latest

all: install lint test cover
lint: isort black flake mypy


install:
	poetry install `if [ "${DEV}" = "0" ]; then echo "--no-dev"; fi`

isort:
	poetry run isort src tests

black:
	poetry run black src tests

flake:
	poetry run flakehell lint src tests

mypy:
	# poetry run mypy src tests --strict --implicit-reexport
	poetry run mypy src tests

test:
	poetry run pytest --cov-report=term-missing --cov=pysignalr --cov-report=xml -v tests

cover:
	poetry run diff-cover coverage.xml

build:
	poetry build

release-patch:
	bumpversion patch
	git push --tags
	git push

release-minor:
	bumpversion minor
	git push --tags
	git push

release-major:
	bumpversion major
	git push --tags
	git push