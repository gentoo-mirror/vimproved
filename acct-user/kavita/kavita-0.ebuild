# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

KEYWORDS="~amd64"

ACCT_USER_HOME=/var/lib/kavita
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( kavita )

acct-user_add_deps
