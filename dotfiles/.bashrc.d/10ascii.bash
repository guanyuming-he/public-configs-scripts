# Boucher et al. found that bad characters are a good source of supply chain
# attacks. 
# I won't write Unicode texts as much as possible, and the following are good
# funcs to check if any file has any character other than printable ASCIIs.

_ascii_check_params() {
	if [[ $# != "1" ]]; then
		echo "invalid num of args."
		return 1
	fi

	if ! [[ -f "$1" ]]; then
		echo "$1 cannot be accessed as a file."
		return 1
	fi

	return 0
}

ascii_only() {
	_ascii_check_params "$1" || return 1

	# delete all printable asciis and see if there's any left.
	if LC_ALL=C tr -d '\11\12\15\40-\176' <"$1" | grep -q .; then
		echo "No."
	else
		echo "Yes."
	fi
}

# print all that are not ascii printable in hex.
ascii_print() {
	_ascii_check_params "$1" || return 1

	# delete all printable asciis and see if there's any left.
	LC_ALL=C tr -d '\11\12\15\40-\176' <"$1" | od -An -tx1
}

# Erase all that are not ascii printable
ascii_erase() {
	_ascii_check_params "$1" || return 1

	# delete all printable asciis and see if there's any left.
	tmp=$(mktemp XXXXXXXX)
	if LC_ALL=C tr -cd '\11\12\15\40-\176' <"$1" >$tmp; then
		mv $tmp "$1"
	else
		rm $tmp
		echo "Could not erase non-asciis."
		return 1
	fi
}

