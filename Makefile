COMPONENT := $(notdir $(CURDIR))
PKG_RELEASE ?= 1
PKG_VERSION ?= $(shell node -e "console.log(require('./package.json').st2_version)")
PREFIX ?= /opt/stackstorm/chatops
VIRTUALENV_DIR ?= venv
PYTHON ?= python2.7
REQUIREMENTS = Jinja2 PyYAML

ifneq (,$(wildcard /etc/debian_version))
	DEBIAN := 1
	DESTDIR ?= $(CURDIR)/debian/$(COMPONENT)
else
	REDHAT := 1
endif

.PHONY: all build test clean distclean install
all: build

build:
	chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
	npm install --production --force
	npm cache verify && npm cache clean --force

test:
	npm test

clean:
	rm -Rf node_modules/

distclean: clean
	rm -Rf $(VIRTUALENV_DIR)

install: changelog
	mkdir -p $(DESTDIR)$(PREFIX)
	cp -R $(CURDIR)/bin $(DESTDIR)$(PREFIX)/bin
	cp -R $(CURDIR)/node_modules $(DESTDIR)$(PREFIX)
	cp -R $(CURDIR)/external-scripts.json $(DESTDIR)$(PREFIX)
	cp -R $(CURDIR)/st2chatops.env $(DESTDIR)$(PREFIX)
	install -m644 $(CURDIR)/conf/logrotate.conf $(DESTDIR)/etc/logrotate.d/st2chatops

.PHONY: virtualenv
virtualenv:
	test -d $(VIRTUALENV_DIR) || virtualenv --no-site-packages --python=$(PYTHON) $(VIRTUALENV_DIR)

.PHONY: requirements
requirements: virtualenv
	. $(VIRTUALENV_DIR)/bin/activate; pip install $(REQUIREMENTS)

.PHONY: test-update
test-update: update
	git diff --exit-code packagingenv/*/Dockerfile testingenv/*/Dockerfile

.PHONY: update
update: update-packagingenv update-testingenv

.PHONY: update-packagingenv
update-packagingenv: requirements
	. $(VIRTUALENV_DIR)/bin/activate; python update.py packagingenv

.PHONY: update-testingenv
update-testingenv: requirements
	. $(VIRTUALENV_DIR)/bin/activate; python update.py testingenv

changelog:
ifeq ($(DEBIAN),1)
	debchange -v $(PKG_VERSION)-$(PKG_RELEASE) -M ""
endif

.PHONY: docker-dev-build
docker-dev-build:
	docker build --tag st2chatops-dev dev

.PHONY: docker-dev
docker-dev:
	docker images st2chatops-dev 1>/dev/null || make docker-dev-build
	docker run -it --rm --publish 127.0.0.1:8081:8081/tcp --volume $$(pwd):/app st2chatops-dev
