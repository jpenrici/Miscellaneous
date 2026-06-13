# -----------------------------------------------------------------------------
# Template Logic
# -----------------------------------------------------------------------------

# Resolve template path based on project type
_resolve_template() {
    local type="$1"
    local template_path="${TEMPLATES_DIR}/${type}"

    if [[ -d "$template_path" ]]; then
        echo "$template_path"
    else
        _error "Template '$type' not found."
    fi
}

# Copy template into target directory
_copy_template() {
    local template_dir="$1"
    local target_dir="$2"

    _info "Applying template: $(basename "$template_dir")"

    # Copy including hidden files
    shopt -s dotglob
    cp -r "$template_dir"/* "$target_dir" 2>/dev/null || true
    shopt -u dotglob
}

# Apply simple placeholder substitution
_apply_placeholders() {
    local target_dir="$1"
    local project_name="$2"

    _info "Applying placeholders"

    # Find all files and replace placeholder
    while IFS= read -r -d '' file; do
        if [[ -f "$file" ]]; then
            sed -i "s/{{PROJECT_NAME}}/${project_name}/g" "$file" 2>/dev/null || true
        fi
    done < <(find "$target_dir" -type f -print0)
}

# Ensure scripts are executable (best-effort)
_fix_permissions() {
    local target_dir="$1"
    find "$target_dir" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
}

# Main template application pipeline
_apply_template() {
    local target_dir="$1"
    local project_type="$2"

    if [[ ! -d "$target_dir" ]]; then
        _error "'$target_dir' not found!"
    fi

    local template_dir
    template_dir="$(_resolve_template "$project_type")"

    _copy_template "$template_dir" "$target_dir"
    _apply_placeholders "$target_dir" "$(basename "$target_dir")"
    _fix_permissions "$target_dir"
}
