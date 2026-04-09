# -----------------------------------------------------------------------------
# Colors
# Enabled only when stdout is an interactive terminal with color support.
# Falls back to empty strings — safe for log redirection and pipes.
# -----------------------------------------------------------------------------

_setup_colors() {
    if [[ -t 1 ]] && command -v tput &>/dev/null && tput colors &>/dev/null 2>&1; then
        CLR_OK="\033[0;32m"      # green      — success
        CLR_WARN="\033[0;33m"    # yellow     — warning
        CLR_FAIL="\033[0;31m"    # red        — failure
        CLR_INFO="\033[0;34m"    # blue       — informational
        CLR_SECTION="\033[1;37m" # bold white — section headers
        CLR_RESET="\033[0m"
    else
        CLR_OK=""
        CLR_WARN=""
        CLR_FAIL=""
        CLR_INFO=""
        CLR_SECTION=""
        CLR_RESET=""
    fi
}
