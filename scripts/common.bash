#
# Common functions used by other scripts

# param $1 prompt
# @returns 0 on yes
# 1 on no, and keeps asking if not one of them.
ask_yn() {
	local yn
	
	while true; do
		read -p "$1 [y/n]:" yn
		yn="${yn,,}"  # convert to lowercase
		yn="${yn// /}" # remove trailing spaces
		case ${yn} in
			y|yes) return 0 ;;
			n|no) return 1 ;;
			*) ;;
		esac
	done
}

error() {
	echo "[ERROR] $*" >&2
}

test_root() {
	if [[ $EUID != 0 ]]; then
		error "Please run as root."
		exit 1
	fi
}

# Securely deploy src to dst, chowned as root:root.  If I cp + chown,
# then there's a window in between where the dest files can be overridden by
# the previous owner user.
#
# Thus, I first create temp dir as root:root 0700, cp to it, chown within, and
# then replace dest.
#
# $1: src $2: dst
secure_deploy_root_dir() {
	test_root

	if [[ $# != 2 ]]; then
		error "Usage: secure_deploy_root_dir src dst"
		return 1
	fi

	local src="$1"
	local dst="$2"

	if ! [[ -d "$1" ]]; then
		error "No such dir: $1"
		return 1
	fi
	src=$(realpath "$1")

	if [[ -e "$2" ]]; then
		ask_yn "$2 exists. Proceed to remove and replace it?" \
			|| return 1
		dst=$(realpath "$2")
	fi
	if [[ -z "$dst" || "$dst" == / ]]; then
		error "Dangerous dst. Abort now."
		return 1
	fi

	# Execute these within a subshell so that I can set options
	(
		set -exuo pipefail 

		tmpdir=$(mktemp -d)
		chmod 0700 "$tmpdir"
		chown root:root "$tmpdir"

		cp -ra "$src" "$tmpdir/src"
		chown -R root:root "$tmpdir/src"

		rm -rf "$dst"
		mv "$tmpdir/src" "$dst"

		rmdir "$tmpdir"	
	)
}
