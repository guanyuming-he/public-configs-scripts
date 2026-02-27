# Boucher et al. found that bad characters are a good source of supply chain
# attacks. 
# I won't write Unicode texts as much as possible, and the following are good
# funcs to check if any file has any character other than printable ASCIIs.

ascii_only() {
	if [[ $# != "1" ]]; then
		echo "invalid num of args."
		return 1
	fi

	if ! [[ -f "$1" ]]; then
		echo "$1 cannot be accessed as a file."
		return 1
	fi

	# delete all printable asciis and see if there's any left.
	if tr -d '\11\12\15\40-\176' <"$1" | grep -q .; then
		echo "No."
	else
		echo "Yes."
	fi
}
