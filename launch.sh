#!/bin/sh
echo "$0" "$@"
progdir="$(dirname "$0")"
cd "$progdir" || exit 1
[ -f "$progdir/debug" ] && set -x
PAK_NAME="$(basename "$progdir")"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$progdir/lib"
echo 1 >/tmp/stay_awake

SERVICE_NAME="report"
HUMAN_READABLE_NAME="Report"

service_on() {
    cd "$SDCARD_PATH" || return 1

    show_message "Running $HUMAN_READABLE_NAME" forever
    PROGDIR="$progdir" "$progdir/bin/report" >"$SDCARD_PATH/report.txt" 2>&1
    show_message "Report available at $SDCARD_PATH/report.txt" 2
}

service_off() {
    killall "$SERVICE_NAME"
}

show_message() {
    message="$1"
    seconds="$2"

    if [ -z "$seconds" ]; then
        seconds="forever"
    fi

    killall sdl2imgshow >/dev/null 2>&1 || true
    echo "$message"
    if [ "$seconds" = "forever" ]; then
        "$progdir/bin/sdl2imgshow" \
            -i "$progdir/res/background.png" \
            -f "$progdir/res/fonts/BPreplayBold.otf" \
            -s 27 \
            -c "220,220,220" \
            -q \
            -t "$message" >/dev/null 2>&1 &
    else
        "$progdir/bin/sdl2imgshow" \
            -i "$progdir/res/background.png" \
            -f "$progdir/res/fonts/BPreplayBold.otf" \
            -s 27 \
            -c "220,220,220" \
            -q \
            -t "$message" >/dev/null 2>&1
        sleep "$seconds"
    fi
}

cleanup() {
    rm -f /tmp/stay_awake
    killall sdl2imgshow >/dev/null 2>&1 || true
}

main() {
    trap "cleanup" EXIT INT TERM HUP QUIT

    service_on
    killall sdl2imgshow >/dev/null 2>&1 || true
}

main "$@" >"$LOGS_PATH/$PAK_NAME.txt" 2>&1
