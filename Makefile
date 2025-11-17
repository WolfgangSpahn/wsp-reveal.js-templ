# Makefile for aidu_ai package

# system python interpreter
PY=python3
FIND=find
SETUP=./scripts/install.sh
INIT=./scripts/init.sh
DEPLOY=./scripts/deploy.sh

# Source directory
SRC=src
IMAGES=~/Projects/Images

help:            ## Show this help.
	@grep -h "##" $(MAKEFILE_LIST) | grep -v grep | sed -e "s/\$$//" -e "s/##//"

.PHONY: setup init publish
setup:         ## Setup the environment
	./setup.sh

.PHONY: deploy
deploy:         ## Deploy the package to PyPI
	@echo "======================================================================"
	@echo "Create public dir"
	@echo "======================================================================"
	$(DEPLOY)

clean:
	rm -rf reveal.js
	rm -rf public
	$(FIND) . -type f -name '*~' -delete

images:        ## Link to images directory
	@echo "======================================================================"
	@echo "Link to images directory at $(IMAGES)"
	@echo "======================================================================"
	ln -s $(IMAGES) src/assets/images

.PHONY: run
run:	         ## Run a single agent example
run: 
	@echo "======================================================================"
	@echo "Run python web server at http://localhost:8000 serving public"
	@echo "======================================================================"
	$(PY) -m http.server 8000 -d public





