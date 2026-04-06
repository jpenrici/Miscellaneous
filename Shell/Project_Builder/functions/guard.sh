# -----------------------------------------------------------------------------
# Guard: refuse to run as root
# -----------------------------------------------------------------------------
_check_not_root() {
    if [[ "${EUID}" -eq 0 ]]; then
        echo -e "  ${CLR_FAIL}[FAIL]${CLR_RESET} Running as root is strictly forbidden." >&2
        exit 1
    fi

    _pass "Not running as root (UID=${EUID})"
}
