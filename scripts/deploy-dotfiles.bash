#!/bin/bash

# Dotfiles are installed to dirs by creating links between them.
# Symlinks may not work for some programs which refuse to read symlink configs
# (probably for security reasons)
# This script must be executed inside the dir it resides in.
#
# Each dir will have a list of dot files to install to.

set -u

###############################################################################
# Variables 
###############################################################################

readonly -a DIRS=(
	.
	.bashrc.d
	.config/vifm
)

readonly -a DOTFILES_0=(
	.bashrc
	.bash_aliases
	.vimrc
)
readonly -a DOTFILES_1=(
	10findsrc.bash	
	10prompt.bash	
	10texlive.bash	
)
readonly -a DOTFILES_2=(
	vifmrc
)

###############################################################################
# Functions
###############################################################################
. ./common-deploy-dotfiles.bash

###############################################################################
# Main
###############################################################################
main
