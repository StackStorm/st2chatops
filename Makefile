COMPONENT := $(notdir $(CURDIR))
PKG_RELEASE ?= 1
PKG_VERSION ?= $(shell node -e "console.log(require('./package.json').st2_version)")
PREFIX ?= /opt/stackstorm/hubot

ifneq (,$(wildcard /etc/debian_version))
	DEBIAN := 1
	DESTDIR ?= $(CURDIR)/debian/$(COMPONENT)
else
	REDHAT := 1
endif

.PHONY: all build test clean install
all: build

build:
	npm install --production
	npm cache clean

test:
	npm test

clean:
	rm -Rf node_modules/
	mkdir -p node_modules/

install: changelog
	mkdir -p $(DESTDIR)$(PREFIX)
	cp -R $(CURDIR)/bin $(DESTDIR)$(PREFIX)/bin
	cp -R $(CURDIR)/node_modules $(DESTDIR)$(PREFIX)
	cp -R $(CURDIR)/hubot-scripts.json $(DESTDIR)$(PREFIX)
	cp -R $(CURDIR)/external-scripts.json $(DESTDIR)$(PREFIX)
	cp -R $(CURDIR)/st2hubot.env $(DESTDIR)$(PREFIX)

changelog:
ifeq ($(DEBIAN),1)
	debchange -v $(PKG_VERSION)-$(PKG_RELEASE) -M ""
endif
