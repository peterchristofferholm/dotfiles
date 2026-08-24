# =============================================================================
# Status line
#
# Vendored from tmux-powerkit, keeping only the pieces actually in use. 
#
# Glyphs are Nerd Font (powerline separators plus Material Design icons), so
# the terminal font has to be a patched one.
# =============================================================================

## Palette - Catppuccin Frappe ################################################

set -g @sl_base   "#303446"  # base
set -g @sl_bg     "#414559"  # surface0 - status bar background
set -g @sl_fg     "#c6d0f5"  # text

# Session block, by client mode
set -g @sl_session_fg        "#303446"
set -g @sl_session_bg        "#ca9ee6"  # mauve    - normal
set -g @sl_session_prefix_bg "#ef9f76"  # peach    - prefix pressed
set -g @sl_session_copy_bg   "#85c1dc"  # sapphire - copy mode

# Window tabs
set -g @sl_win_bg            "#51576d"  # surface1
set -g @sl_win_idx_bg        "#74788a"
set -g @sl_win_fg            "#dddee2"
set -g @sl_win_active_bg     "#f4b8e4"  # pink
set -g @sl_win_active_idx_bg "#f6c6e9"
set -g @sl_win_active_fg     "#6c5165"

# Right-hand segments, by health
set -g @sl_ok_bg        "#51576d"
set -g @sl_ok_icon_bg   "#74788a"
set -g @sl_ok_fg        "#dddee2"
set -g @sl_info_bg      "#8caaee"  # blue   - e.g. battery charging
set -g @sl_info_icon_bg "#a3bbf1"
set -g @sl_info_fg      "#3e4b69"
set -g @sl_warn_bg      "#e5c890"  # yellow
set -g @sl_warn_icon_bg "#ead3a6"
set -g @sl_warn_fg      "#655940"
set -g @sl_err_bg       "#e78284"  # red
set -g @sl_err_icon_bg  "#eb9b9c"
set -g @sl_err_fg       "#66393a"

# Panes and popups
set -g @sl_border     "#ca9ee6"  # mauve
set -g @sl_border_dim "#51576d"  # surface1

## Application glyphs #########################################################
# Commands listed here get their own glyph in the window tab; everything else
# falls back to the plain terminal icon in the last rule, which catches any
# command name that no earlier rule rewrote. To add one, insert a line above it.
#
# Continuation lines start at column 0 on purpose: tmux keeps leading
# whitespace inside a quoted value, and a stray space would break the
# substitution list.

set -g @sl_app_icons "#{s|^bash$||;\
s|^zsh$||;\
s|^fish$||;\
s|^sh$||;\
s|^nvim$||;\
s|^vim$||;\
s|^git$||;\
s|^lazygit$||;\
s|^gitui$||;\
s|^gh$||;\
s|^claude$|󰚩|;\
s|^docker$||;\
s|^kubectl$|󱃾|;\
s|^k9s$|󱃾|;\
s|^terraform$||;\
s|^ssh$||;\
s|^man$||;\
s|^less$||;\
s|^fzf$||;\
s|^yazi$||;\
s|^node$||;\
s|^npm$||;\
s|^pnpm$||;\
s|^bun$||;\
s|^deno$||;\
s|^python$||;\
s|^python3$||;\
s|^uv$||;\
s|^cargo$||;\
s|^go$||;\
s|^rg$||;\
s|^fd$||;\
s|^htop$|󰓅|;\
s|^btop$|󰓅|;\
s|^top$|󰓅|;\
s|^make$||;\
s|^tmux$||;\
s|^[a-zA-Z0-9_.+-]+$||\
:pane_current_command}"

# Glyph shown in a window tab. Zoom, bell and mark override the app icon.
set -g @sl_win_icon "#{?window_zoomed_flag,,#{?window_bell_flag,󰂚,#{?window_marked_flag,󰌆,#{E:@sl_app_icons}}}}"

## Status bar #################################################################

set -g status on
set -g status-position top
set -g status-interval 5
set -g status-justify left
set -g status-style "fg=#{@sl_fg},bg=#{@sl_bg}"
set -g status-left-length 100
set -g status-right-length 500

## Session block (status-left) ################################################
# Icon and background both track the client mode: prefix pressed, copy mode, or
# normal. The trailing separator has to blend into whatever the first window
# tab starts with, hence the #{W:} loop - it walks every window and emits the
# index background of the one flagged as first, picking the active colour if
# that window happens to be the current one.

set -g status-left "\
#[fg=#{@sl_session_fg},bold,bg=#{?client_prefix,#{@sl_session_prefix_bg},#{?pane_in_mode,#{@sl_session_copy_bg},#{@sl_session_bg}}}] \
#{?client_prefix, ,#{?pane_in_mode, , }}#S \
#[fg=#{?client_prefix,#{@sl_session_prefix_bg},#{?pane_in_mode,#{@sl_session_copy_bg},#{@sl_session_bg}}},bg=#{W:#{?window_start_flag,#{@sl_win_idx_bg},},#{?window_start_flag,#{@sl_win_active_idx_bg},}}]"

## Window tabs ################################################################
# Each tab is two cells - index, then icon + name - joined by a powerline
# separator, with a leading separator that blends out of the previous tab.
# On an inactive tab that means asking whether the tab to our left is the
# active one: #{W:} builds a "|0=0|1=1|2=0" map of window index to active flag,
# and we match "=1|<our index>=" against it.

set -g window-status-separator ""
set -g window-status-style default
set -g window-status-current-style default
set -g window-status-activity-style italics
set -g window-status-bell-style bold

set -g window-status-format "\
#[range=window|#{window_id}]\
#[fg=#{?#{m:*=1|#{window_index}=*,#{W:|#{window_index}=0,|#{window_index}=1}},#{@sl_win_active_bg},#{@sl_win_bg}},bg=#{@sl_win_idx_bg}]#{?window_start_flag,,}\
#[fg=#{@sl_win_fg},bg=#{@sl_win_idx_bg}]#{?#{==:#{window_index},#{base-index}},, }#{window_index} \
#[fg=#{@sl_win_idx_bg},bg=#{@sl_win_bg}]\
#[fg=#{@sl_win_fg},bg=#{@sl_win_bg}] #{E:@sl_win_icon} #W#{?window_activity_flag, 󱅫,} \
#[norange]"

set -g window-status-current-format "\
#[range=window|#{window_id}]\
#[fg=#{@sl_win_bg},bg=#{@sl_win_active_idx_bg}]#{?window_start_flag,,}\
#[fg=#{@sl_win_active_fg},bg=#{@sl_win_active_idx_bg},bold]#{?#{==:#{window_index},#{base-index}},, }#{window_index} \
#[fg=#{@sl_win_active_idx_bg},bg=#{@sl_win_active_bg}]\
#[fg=#{@sl_win_active_fg},bg=#{@sl_win_active_bg},bold] #{E:@sl_win_icon} #W #{?pane_synchronized,✵,}\
#[norange]"

## Right side #################################################################
# Rendered by a script rather than by tmux formats, because a segment has to be
# able to vanish (no battery on a desktop) and tmux runs #() asynchronously: on
# the first render it produces no output at all, so a format-level test like
# #{?#{<:#(battery),15},...} would compare against the empty string and flash
# the critical colour on every startup. The script returns the finished chain in
# one piece instead, so there is no half-built frame.
#
# The arguments name seg_* functions in the script and give their left-to-right
# order. Thresholds are expanded into the command line by tmux, so the numbers
# below are the only copy - the script has no fallback of its own.

set -g @sl_battery_warning  "30"
set -g @sl_battery_critical "15"

set -g status-right "#(SL_BATTERY_WARNING=#{@sl_battery_warning} \
SL_BATTERY_CRITICAL=#{@sl_battery_critical} \
~/.config/tmux/scripts/statusline-right.sh datetime battery)"

## Segment styles #############################################################
# The script names a health - ok, info, warn, err - and tmux resolves it to
# colours through the pairs below, so nothing in the script mentions a colour or
# a separator glyph. That keeps the palette above as the only place colours are
# written, and keeps every @sl_*_bg reference in this file where it is greppable.
#
# A segment is two cells: the icon on the lightened background, then the text on
# the base one, each entered through a powerline separator. The separators set
# only a foreground. tmux styles accumulate, so the background is still whatever
# the previous cell left behind - which is exactly the colour the separator has
# to blend out of. The first segment inherits status-style, so it blends out of
# the bar itself. That is what lets the script render segments independently,
# without tracking what came before it.
#
# The option names are completed by string interpolation in the script
# (@sl_seg_open_ + health), so grepping for the health name finds more than
# grepping for the whole option name.

set -g @sl_seg_open_ok   "#[fg=#{@sl_ok_icon_bg}]#[fg=#{@sl_ok_fg},bg=#{@sl_ok_icon_bg}]"
set -g @sl_seg_mid_ok    "#[fg=#{@sl_ok_bg}]#[fg=#{@sl_ok_fg},bg=#{@sl_ok_bg}]"

set -g @sl_seg_open_info "#[fg=#{@sl_info_icon_bg}]#[fg=#{@sl_info_fg},bg=#{@sl_info_icon_bg}]"
set -g @sl_seg_mid_info  "#[fg=#{@sl_info_bg}]#[fg=#{@sl_info_fg},bg=#{@sl_info_bg}]"

set -g @sl_seg_open_warn "#[fg=#{@sl_warn_icon_bg}]#[fg=#{@sl_warn_fg},bg=#{@sl_warn_icon_bg}]"
set -g @sl_seg_mid_warn  "#[fg=#{@sl_warn_bg}]#[fg=#{@sl_warn_fg},bg=#{@sl_warn_bg}]"

set -g @sl_seg_open_err  "#[fg=#{@sl_err_icon_bg}]#[fg=#{@sl_err_fg},bg=#{@sl_err_icon_bg}]"
set -g @sl_seg_mid_err   "#[fg=#{@sl_err_bg}]#[fg=#{@sl_err_fg},bg=#{@sl_err_bg}]"

## Panes, messages, popups ####################################################

set -g pane-border-style "#{?pane_synchronized,fg=#{@sl_border},fg=#{@sl_border_dim}}"
set -g pane-active-border-style "fg=#{@sl_border}"

set -g message-style "fg=#{@sl_fg},bg=#{@sl_bg}"
set -g message-command-style "fg=#{@sl_base},bg=#{@sl_win_active_bg}"
set -g mode-style "fg=#{@sl_base},bg=#{@sl_session_copy_bg}"

set -g popup-style "fg=#{@sl_fg},bg=#{@sl_bg}"
set -g popup-border-style "fg=#{@sl_border}"
set -g menu-style "fg=#{@sl_fg},bg=#{@sl_bg}"
set -g menu-selected-style "fg=#{@sl_base},bg=#{@sl_border}"
set -g menu-border-style "fg=#{@sl_border}"

# clock-mode-colour takes a plain colour, not a style, so it is not run through
# format expansion - @sl_border has to be spelled out here.
set -g clock-mode-colour "#ca9ee6"
