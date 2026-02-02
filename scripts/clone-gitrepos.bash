#!/bin/bash
#
# Every time I set up a new computer, I will need to clone some important git
# repos. Hope this script does the job.

# error on expanding Undefined vars
set -u
# Cloning repo doesn't need to fail fast
# set -eo pipefail


# Repos are grouped into topics each of which
# has a base uri, an authentication method, and a list of repos.
# I will be asked to confirm on each topic and each repo.
# I can also add new repos to the list

###############################################################################
# VARIABLES
###############################################################################

readonly -a TOPICS=(
	qubes
	tor
	linux
)
readonly -A BASE_URIS=(
	[qubes]="https://github.com/QubesOS"
	[tor]="https://gitlab.torproject.org/"
	[linux]="https://git.kernel.org/pub/scm/linux/kernel/git"
)
readonly -a REPOS_qubes=(
	qubes-doc
	qubes-core-agent-linux
	qubes-core-admin
)
readonly -a REPOS_tor=(
	tpo/core/tor
)
readonly -a REPOS_linux=(
	stable/linux
	torvalds/linux
)

readonly DEST="${HOME}/Documents/git_repos"
# Remains readonly, will cd back to this dir where the script is called.
readonly CWD=${PWD}

###############################################################################
# FUNCTIONS
###############################################################################

# For ask_yn
. ./common.bash
# Common functions
. ./common-clone-gitrepos.bash

###############################################################################
# MAIN
###############################################################################
main

