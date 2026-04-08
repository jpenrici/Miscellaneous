#!/usr/bin/env bash

# =============================================================================
# Project Builder - creator.sh (Template-based)
# -----------------------------------------------------------------------------
# Purpose:
#   Bootstrap a project by COPYING a template directory and applying minimal
#   substitutions. The template is fully responsible for its internal structure
#   (files, directories, build systems, etc.).
#
# Design principles:
#   - Keep logic minimal and predictable
#   - Delegate complexity to templates
#   - Avoid overengineering (no template engines, no plugins)
#   - Fast execution
#
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# Paths and Constants
# -----------------------------------------------------------------------------
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly APP_NAME="project_builder"
readonly LOG_DIR="${HOME}/.local/share/${APP_NAME}"
readonly COMMON_FUNCTIONS="${SCRIPT_DIR}/functions"
readonly TEMPLATES_DIR="${SCRIPT_DIR}/templates"

DEFAULT_PROJECT_NAME="my_project"
DEFAULT_PROJECT_TYPE="generic"

# -----------------------------------------------------------------------------
# Import Modules
# -----------------------------------------------------------------------------
source "${COMMON_FUNCTIONS}/color.sh"
source "${COMMON_FUNCTIONS}/helpers.sh"
source "${COMMON_FUNCTIONS}/guard.sh"
source "${COMMON_FUNCTIONS}/os_check.sh"
source "${COMMON_FUNCTIONS}/dependencies_check.sh"
source "${COMMON_FUNCTIONS}/directories_check.sh"

# -----------------------------------------------------------------------------
# Utility Functions
# -----------------------------------------------------------------------------

_make_dir() {
    local dir="$1"

    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        _info "Created directory: $dir"
    else
        _warn "Directory already exists: $dir"
    fi
}

# -----------------------------------------------------------------------------
# Dialog UI Wrappers
# -----------------------------------------------------------------------------
_confirm() {
    dialog --title "$1" --yesno "$2" 0 0
}

_notify() {
    dialog --title "$1" --infobox "$2" 0 0
    sleep 2
}

_dialog_run() {
    local result
    local status

    result=$(dialog "$@" --stdout)
    status=$?

    if [[ $status -ne 0 ]]; then
        clear
        _error "Operation cancelled"
    fi

    echo "$result"
}

_input() {
    _dialog_run --inputbox "$1" 0 0
}

_select_project_type() {
    _dialog_run \
        --title "Project Type" \
        --menu "Select project type:" \
        0 0 0 \
        generic "Generic project" \
        cpp "C++ project" \
        python "Python project" \
        shell "Shell project"
}

_select_path() {
    local initial_path="${1:-$HOME/}"

    _dialog_run \
        --title "Select project location" \
        --fselect "$initial_path" 20 70
}

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
        _warn "Template '$type' not found. Falling back to 'generic'."
        echo "${TEMPLATES_DIR}/generic"
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

    local template_dir
    template_dir="$(_resolve_template "$project_type")"

    _copy_template "$template_dir" "$target_dir"
    _apply_placeholders "$target_dir" "$(basename "$target_dir")"
    _fix_permissions "$target_dir"
}

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

# -----------------------------------------------------------------------------
# Argument Parsing
# -----------------------------------------------------------------------------

PROJECT_NAME=""
PROJECT_TYPE=""
PROJECT_PATH=""

_parse_args() {
    if [[ $# -ge 1 ]]; then
        PROJECT_NAME="$1"
        PROJECT_TYPE="${2:-$DEFAULT_PROJECT_TYPE}"
        PROJECT_PATH="${3:-.}"
    fi
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------

main() {
    _setup_colors

    _section "Environment checks"
    _check_not_root
    _check_os
    _check_dependencies "dialog"
    _check_directories "${LOG_DIR}"

    _parse_args "$@"

    local name
    local type
    local project_dir

    if [[ -z "$PROJECT_NAME" ]]; then
        _section "Interactive mode"

        while true; do
            name="$(_input "Enter project name:")"
            name="${name:-$DEFAULT_PROJECT_NAME}"

            default_dir="$PWD/projects/$name"
            project_dir="$(_select_path "$default_dir")"
            project_dir="${project_dir:-$default_dir}"

            # Normalize: ensure directory
            if [[ -f "$project_dir" ]]; then
                project_dir="$(dirname "$project_dir")"
            fi

            if [[ ! -e "$project_dir" ]]; then
                break
            fi

            if _confirm "Alert" "The directory already exists. Do you want to create a copy?"; then
                local suffix=1
                local original_dir="$project_dir"

                while [[ -e "$project_dir" ]]; do
                    project_dir="${original_dir}_${suffix}"
                    ((suffix++))
                done

                _notify "Info" "Using alternative path:\n$project_dir"
                break
            fi
        done

        type="$(_select_project_type)"
        type="${type:-$DEFAULT_PROJECT_TYPE}"
    else
        _section "Non-interactive mode"

        name="$PROJECT_NAME"
        type="$PROJECT_TYPE"
    fi

    _section "Project creation"

    _make_dir "$project_dir"
    _apply_template "$project_dir" "$type"
    _init_git "$project_dir"

    _notify "Info" "Project created at: $project_dir"
    clear

    _pass "Project created at: $project_dir"
}

main "$@"
