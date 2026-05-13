# Assume that no one can see my screen except me,
# then a secure channel to transfer (a small amount of) secret information one
# device to another which has a camera is via qrcodes.
# 
# This script provides a qr_text command for bash,
# which reads text and then displays its qrcode, without storing it temporarily
# on filesystem.

qr_text() {
    local s

	# IFS= disallows read from separating the input by IFS.
    IFS= read -r -s s
    printf '\n'

    if [ "${#s}" -ge 2048 ]; then
        echo "Error: input too long (>= 2048 chars)" >&2
        unset s
        return 1
    fi

    printf '%s' "$s" | qrencode -o - | display -

    unset s
}
