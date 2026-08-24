#!/usr/bin/env bash
# =============================================================================
# Renders the right-hand segments of the tmux status line.
#
# Called from statusline.conf as `#(statusline-right.sh datetime battery)`, once
# per status-interval. Each argument names a `seg_*` function below; they render
# left to right, and the order in that argument list is the order on screen.
#
# Nothing here knows about colours or separator glyphs. A segment names a health
# instead, and the printed text carries @sl_seg_* references that tmux expands
# on the way to the bar — tmux re-expands #{...} and #[...] in the output of
# #(), so the palette stays in statusline.conf and is never parsed back out.
#
# A segment that has nothing to show (no battery on this machine, say) prints
# nothing and simply disappears from the bar.
# =============================================================================

set -uo pipefail

# --- Segment rendering -------------------------------------------------------

readonly HEALTHS=" ok info warn err "

# Usage: segment <health> <icon> <text>
#   health: ok | info | warn | err  (selects an @sl_seg_*_<health> pair)
segment() {
    local health=$1 icon=$2 text=$3

    # An unknown health would expand to an empty style and render the segment
    # unpainted, which is easy to miss — say so instead.
    if [[ $HEALTHS != *" $health "* ]]; then
        printf 'statusline-right: no such health: %s\n' "$health" >&2
        return 0
    fi

    printf '#{E:@sl_seg_open_%s}%s #{E:@sl_seg_mid_%s} %s ' \
        "$health" "$icon" "$health" "$text"
}

# --- Segments ----------------------------------------------------------------

seg_datetime() {
    local now
    printf -v now '%(%d/%m %H:%M)T' -1
    segment ok $'\U000F00F0' "$now"
}

seg_battery() {
    local dir="" candidate percent status health icon
    local warning=${SL_BATTERY_WARNING:-} critical=${SL_BATTERY_CRITICAL:-}

    for candidate in /sys/class/power_supply/BAT* /sys/class/power_supply/battery; do
        [[ -r $candidate/capacity ]] && { dir=$candidate; break; }
    done
    [[ -n $dir ]] || return 0 # desktop or VM — no battery to report

    percent=$(<"$dir/capacity")
    # Not every driver exposes status; note that $(<f 2>/dev/null) silently
    # reads nothing, so guard the file rather than the redirection.
    status=unknown
    [[ -r $dir/status ]] && status=$(<"$dir/status")

    case ${status,,} in
        charging | "not charging")
            health=info
            icon=$'\U000F0084'
            ;;
        full)
            health=ok
            icon=$'\U000F0084'
            ;;
        *)
            # statusline.conf holds the only copy of the thresholds. If they did
            # not arrive, report a plain battery rather than inventing a number
            # here that could drift away from the one in the config.
            if [[ ! $critical =~ ^[0-9]+$ || ! $warning =~ ^[0-9]+$ ]]; then
                printf 'statusline-right: battery thresholds unset\n' >&2
                health=ok
                icon=$'\U000F0079'
            elif ((percent < critical)); then
                health=err
                icon=$'\U000F10CC'
            elif ((percent < warning)); then
                health=warn
                icon=$'\U000F0083'
            else
                health=ok
                icon=$'\U000F0079'
            fi
            ;;
    esac

    segment "$health" "$icon" "${percent}%"
}

# --- Main --------------------------------------------------------------------

for name in "$@"; do
    if declare -F "seg_$name" >/dev/null; then
        "seg_$name"
    else
        # Goes to the tmux server log rather than the status bar: a stray style
        # escape in the bar would corrupt every segment after it.
        printf 'statusline-right: no such segment: %s\n' "$name" >&2
    fi
done
