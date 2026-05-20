# Assume that no one can see my screen except me,
# then a secure channel to transfer (a small amount of) secret information one
# device to another which has a camera is via qrcodes.
# 
# This script provides a qr_text command for bash,
# which reads text and then displays its qrcode, without storing it temporarily
# on filesystem.

qr_text() {
	local s

	if [[ -n "$1" ]]; then
		s="$1"
	else
		# IFS= disallows read from separating the input by IFS.
		IFS= read -rsp "Input text which will be encoded: " s
		printf '\n'
	fi

	if [[ "${#s}" -ge 2048 ]]; then
		echo "Error: input too long (>= 2048 chars)" >&2
		unset s
		return 1
	fi

	printf '%s' "$s" | qrencode -o - | display -

	unset s
}

qr_file() {
	local fp

	if [[ -n "$1" ]]; then
		fp="$1"
	else
		read -ep "Please input file path: " fp
		printf '\n'
	fi

	# realpath doesn't expand ~, so I'll have to do it manually.
	fp=$(realpath "${fp/#\~/$HOME}")
	if ! [[ -f "$fp" ]]; then
		echo "No such file: $fp" >&2
		unset fp
		return 1
	fi

	qrencode -r "$fp" -o - | display -

	unset fp
}
