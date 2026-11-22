Changelog
========================================================================

in development
------------------------------------------------------------------------

Added
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* ``npm test``: an end-to-end test that starts ``bin/hubot --test`` (hubot's Shell adapter) against
  a running StackStorm. It checks that the action aliases load and show in ``!help`` and in
  ``<bot> help``, then runs ``!pack get core`` and waits for the reply to come back through the
  ``chatops.notify`` rule. A unit test covers ``scripts/st2-help.js``. Uses Node's built-in test
  runner, so there are no test dependencies.

    Contributed by @bishopbm1
* A changelog file.

    Contributed by @nzlosh
* EL9 support and node20 support

    Contributed by @amanda11
* Ubuntu Jammy support

    Contributed by @nzlosh

Fixed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Fix the CI build caused by different OS version.
* Fix CircleCI build for forked PRs.

    Contributed by @armab

Changed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Node.js 24 LTS (``.nvmrc``, ``engines``), and current dependencies:

  - hubot 11.3 -> 14.1 (Express 5, ``connect-multiparty`` removed, and a CommandBus for
    commands).
  - hubot-stackstorm 0.13 -> 0.14. It works with hubot 14, selects the Slack formatting for
    hubot-slack's new adapter name, and no longer exits when the StackStorm API returns an error
    body without ``faultstring``. It is vendored as ``vendor/hubot-stackstorm-0.14.0.tgz``:
    ``.npmrc`` blocks git dependencies, and the build then needs only the npm registry. To update
    it, run ``npm pack`` in hubot-stackstorm, replace the tarball and the version in
    ``package.json``, then run ``npm install``.
  - @hubot-friends/hubot-slack 3.1 -> 3.8.
  - ``overrides`` replace st2client's ``axios`` 0.21 with 1.20 and ``eventsource`` 0.1 with 2.0.
    Both had published advisories, and eventsource's was critical. They also pin
    ``body-parser`` 2.4.0 and ``follow-redirects`` 1.16.2: security fixes that are still inside
    the 14-day window, reviewed by hand and listed in ``.npmrc`` with the date each pin can go.
    Production dependencies have no ``npm audit`` findings.
  - Removed ``botbuilder``. It was added for the Microsoft Teams adapter, which is gone.
  - ``npm-shrinkwrap.json`` regenerated with npm 11 (lockfile v3).
  - ``.npmrc`` with supply-chain guardrails: no install scripts, no git dependencies, only package
    versions published at least 14 days ago.
* ``scripts/st2-help.js`` removes hubot 14's built-in ``help`` command. That command answers
  ``<bot> help`` before any script sees it, and lists only CommandBus commands, not the StackStorm
  aliases. With it removed, hubot-help answers ``<bot> help`` and ``!help`` alike, as before.
  ``scripts/*.js`` are shipped in the RPM and the Docker image.
* ``bin/hubot`` uses ``HUBOT_ADAPTER`` (``slack`` means the bundled hubot-slack) instead of always
  loading Slack, so ``bin/hubot --test`` (the Shell adapter) works again. It runs from a temporary
  directory, because the Shell adapter writes its history file to the working directory.
* RPM: ``Requires: nodejs >= 1:24``. RHEL's nodejs has Epoch 1, so the old ``>= 20.0`` accepted
  any version. The package is ``noarch``, since there are no native modules. ``make build`` runs
  ``npm ci --omit=dev`` (no more ``chown`` of ``/root/st2chatops``), and ``make rpm`` is added.
  The EL9 packaging image uses the ``nodejs:24`` module, without npm 6 or node-gyp.
* ``Dockerfile`` on ``node:24-alpine`` with ``npm ci``, running as the ``node`` user. Its ``CMD``
  works now; it used to treat ``source ... && ...`` as a program name.
* Removed ``dev/``, the Teams-era development image (Python 2, a git dependency, Node 20), and
  ``scripts/self-check.sh`` (Python 2, EL7).

    Contributed by @bishopbm1
* Updated hubot-slack to "^4.10.0"

    Contributed by @lopf

* Removed EL7 and bionic
    Contributed by @amanda11

Removed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Remove skills-validator from npm-shrinkwrap.json

    Contributed by @armab


v0.7.0
------------------------------------------------------------------------
