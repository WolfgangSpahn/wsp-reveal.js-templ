# Makefile for aidu_ai package

# system python interpreter
PY=python3
FIND=find
INSTALL=./scripts/install.sh
INIT=./scripts/init.sh
DEPLOY=./scripts/deploy.sh

# Source directory
SRC=src
IMAGES=~/Projects/images

help:            ## Show this help.
	@grep -h "##" $(MAKEFILE_LIST) | grep -v grep | sed -e "s/\$$//" -e "s/##//"

.PHONY: install init publish
install:         ## install the environment
	$(INSTALL)

.PHONY: deploy
deploy:         ## Deploy the package to PyPI
	@echo "======================================================================"
	@echo "Create public dir"
	@echo "======================================================================"
	$(DEPLOY)

.PHONY: broadcast
broadcast:         ## Initialize seminar server
	@echo "======================================================================"
	@echo "Initialize seminar server"
	@echo "======================================================================"
	cd seminar-server && npm start


clean:
	rm -rf reveal.js
	rm -rf public
	$(FIND) . -type f -name '*~' -delete
	rm -rf plugins
	rm -rf tmp-plugins
	rm -rf seminar-server

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





