# -----------------------------------------------------------------------------
# Application directories
# -----------------------------------------------------------------------------
_check_directories() {
    local dirs=($1)
    if [[ -z "${dirs}" ]]; then
        return
    fi
    for dir in "${dirs[@]}"; do
        if [[ ! -d "${dir}" ]]; then
            mkdir -p "${dir}"
            _pass "Created: ${dir}"
        else
            _pass "Exists:  ${dir}"
        fi
    done
}
