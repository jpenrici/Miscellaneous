# -----------------------------------------------------------------------------
# Git Initialization
# -----------------------------------------------------------------------------

_init_git() {
    local base="$1"

    if command -v git &>/dev/null; then
        if _confirm "Git" "Initialize git repository?"; then
            (cd "$base" && git init &>/dev/null)
            _info "Git repository initialized"
        fi
    fi
}
