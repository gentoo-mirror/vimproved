# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for the traefik daemon"
ACCT_USER_ID=0
ACCT_USER_GROUPS=( traefik )

acct-user_add_deps
