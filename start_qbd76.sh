#!/bin/sh
set -eu

QBD76_DIR=$(CDPATH='' cd -P -- "$(dirname -- "$0")" && pwd)
QBD76_LOADER="${QBD76_DIR}/ram_loader"
QBD76_FIRMWARE="${QBD76_DIR}/verified_uac2_release_cb3dbc61.bix"
QBD76_EXPECTED_LOADER_SHA256="03450e5a205da3f8d6a037692f441351de6ac78d4d4b9c7daf059b42aebf8273"
QBD76_EXPECTED_FIRMWARE_SHA256="cb3dbc6145cab42fc0cecb141bb6ab44a05a297b7a32703a54a4a26a2c54e236"

qbd76_sha256() {
    /usr/bin/openssl dgst -sha256 "$1" | /usr/bin/awk '{print $NF}'
}

qbd76_is_ready() {
    /usr/sbin/ioreg -p IOUSB -l -w0 |
        /usr/bin/grep -F '"USB Product Name" = "Chord QBD76 HDSD"' >/dev/null
}

if [ ! -x "${QBD76_LOADER}" ]; then
    printf '%s\n' "error: RAM loader is missing or not executable: ${QBD76_LOADER}" >&2
    exit 1
fi

if [ ! -r "${QBD76_FIRMWARE}" ]; then
    printf '%s\n' "error: firmware is missing or unreadable: ${QBD76_FIRMWARE}" >&2
    exit 1
fi

if [ "$(qbd76_sha256 "${QBD76_LOADER}")" != "${QBD76_EXPECTED_LOADER_SHA256}" ]; then
    printf '%s\n' "error: RAM loader SHA-256 mismatch; refusing to run" >&2
    exit 1
fi

if [ "$(qbd76_sha256 "${QBD76_FIRMWARE}")" != "${QBD76_EXPECTED_FIRMWARE_SHA256}" ]; then
    printf '%s\n' "error: firmware SHA-256 mismatch; refusing to load" >&2
    exit 1
fi

if [ ! -r /opt/homebrew/opt/libusb/lib/libusb-1.0.0.dylib ]; then
    printf '%s\n' "error: Homebrew libusb runtime is unavailable" >&2
    printf '%s\n' "install it with: brew install libusb" >&2
    exit 1
fi

if qbd76_is_ready; then
    printf '%s\n' "Ready: Chord QBD76 HDSD is already enumerated; no reload needed."
    exit 0
fi

printf '%s\n' "Loading verified QBD76 UAC2 firmware into FX2 RAM..."
"${QBD76_LOADER}" --load-verified-bix "${QBD76_FIRMWARE}"

QBD76_ATTEMPT=1
while [ "${QBD76_ATTEMPT}" -le 50 ]; do
    if qbd76_is_ready; then
        printf '%s\n' "Ready: Chord QBD76 HDSD is enumerated."
        exit 0
    fi
    /bin/sleep 0.2
    QBD76_ATTEMPT=$((QBD76_ATTEMPT + 1))
done

printf '%s\n' "error: RAM load completed, but Chord QBD76 HDSD did not enumerate within 10 seconds" >&2
exit 1
