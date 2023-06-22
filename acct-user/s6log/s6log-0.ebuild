# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for logging with sys-apps/s6."
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( s6log )

acct-user_add_deps
