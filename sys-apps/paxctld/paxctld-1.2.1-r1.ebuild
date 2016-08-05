# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit systemd

DESCRIPTION="PaX flags maintenance daemon"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="https://www.grsecurity.net/${PN}/${PN}_${PV}.orig.tar.gz
	https://dev.gentoo.org/~blueness/hardened-sources/${PN}/${PN}_${PV}.orig.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="pam"

RDEPEND=""
DEPEND=""

src_prepare() {
	# Respect Gentoo flags and don't strip
	sed -i \
		-e '/^CC/d' \
		-e '/^CFLAGS/d' \
		-e '/^LDFLAGS/d' \
		-e '/STRIP/d' \
		Makefile

	eapply_user
}

src_install() {
	default
	newinitd "${FILESDIR}/${PN}-initd" "${PN}"
	newconfd "${FILESDIR}/${PN}-confd" "${PN}"
	systemd_dounit "${S}/rpm/${PN}.service"
}
