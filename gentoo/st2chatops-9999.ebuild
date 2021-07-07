# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 eutils

DESCRIPTION="StackStorm chatops native packages, includes hubot, hubot-stackstorm and pre-installed adapters for many Chat services."
HOMEPAGE="https://docs.stackstorm.com/chatops/"
EGIT_REPO_URI="https://github.com/StackStorm/st2chatops.git"
EGIT_BRANCH="master"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="
	net-libs/nodejs[npm]
"
RDEPEND="${DEPEND}"

src_compile() {
	emake
}

src_install() {
	dodir /etc/logrotate.d
	keepdir /var/log/st2
	DESTDIR=${D} emake install
}
