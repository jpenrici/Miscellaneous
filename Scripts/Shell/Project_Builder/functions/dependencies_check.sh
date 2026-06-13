# -----------------------------------------------------------------------------
# Dependencies check
# -----------------------------------------------------------------------------

_check_dependencies() {
    local dependencies=($1)
    if [[ -z "${dependencies}" ]]; then
        return
    fi
    for tool in "${dependencies[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            _error "This application requires ${tool}. Abort!"
            exit 1
        else
            _pass "Exists: ${tool}"
        fi
    done
}
