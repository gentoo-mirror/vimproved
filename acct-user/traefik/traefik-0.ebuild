# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="Group for the Traefik daemon."
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( traefik )

acct-user_add_deps
