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
