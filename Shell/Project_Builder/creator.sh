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
# Interactive mode:
#
#     ./creator.sh --dialog
#     ./creator.sh --zenity
#     ./creator.sh [--console]
#
# Non-interactive mode:
#
#     ./creator.sh <project name> <project type> <project path>
#
#     Example:
#
#         ./creator.sh "My project Name" "shell" "./project/My Project"
#
# Help:
#
#     ./creator.sh --help     - shows this help
#
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# Paths and Constants
# -----------------------------------------------------------------------------

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly APP_NAME="Project Builder"
readonly COMMON_FUNCTIONS="${SCRIPT_DIR}/functions"
readonly TEMPLATES_DIR="${SCRIPT_DIR}/templates"

DEFAULT_PROJECT_NAME="my_project"
DEFAULT_PROJECT_TYPE="generic"
DEFAULT_PROJECT_PATH="$PWD/project"
DEFAULT_TUI=0 # Text User Interface : 0 - Console, 1 - Dialog, 2 - Zenity

# -----------------------------------------------------------------------------
# Import Modules
# -----------------------------------------------------------------------------

source "${COMMON_FUNCTIONS}/color.sh"
source "${COMMON_FUNCTIONS}/helpers.sh"
source "${COMMON_FUNCTIONS}/guard.sh"
source "${COMMON_FUNCTIONS}/os_check.sh"
source "${COMMON_FUNCTIONS}/dependencies_check.sh"
source "${COMMON_FUNCTIONS}/directories_check.sh"
source "${COMMON_FUNCTIONS}/ui_console.sh"
source "${COMMON_FUNCTIONS}/ui_dialog.sh"
source "${COMMON_FUNCTIONS}/ui_zenity.sh"
source "${COMMON_FUNCTIONS}/template_logic.sh"
source "${COMMON_FUNCTIONS}/git_initialization.sh"

# -----------------------------------------------------------------------------
# Templates
# -----------------------------------------------------------------------------
mapfile -t TEMPLATES < <(
    find "$TEMPLATES_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort
)

if [[ ${#TEMPLATES[@]} -eq 0 ]]; then
    _error "No templates found in $TEMPLATES_DIR"
fi

# -----------------------------------------------------------------------------
# Utility Functions
# -----------------------------------------------------------------------------

_make_dir() {
    local dir="$1"

    if [[ ! -d "$dir" ]]; then
        #         mkdir -p "$dir"
        _info "Created directory: $dir"
    else
        _warn "Directory already exists: $dir"
    fi
}

# -----------------------------------------------------------------------------
# Argument Parsing
# -----------------------------------------------------------------------------

PROJECT_NAME=""
PROJECT_TYPE=""
PROJECT_PATH=""
CURRENT_TUI=$DEFAULT_TUI

_parse_args() {
    # Command Line
    if [[ $# -ge 1 ]]; then
        PROJECT_NAME="$1"
        PROJECT_TYPE="${2:-$DEFAULT_PROJECT_TYPE}"
        PROJECT_PATH="${3:-$DEFAULT_PROJECT_PATH}"
    fi

    # User Interface
    if [[ $# -eq 1 ]]; then
        case "$1" in
        "--dialog") CURRENT_TUI=1 ;;
        "--zenity") CURRENT_TUI=2 ;;
        *) CURRENT_TUI=$DEFAULT_TUI ;;
        esac

        PROJECT_NAME=""
        PROJECT_TYPE=""
        PROJECT_PATH=""
    fi
}

# -----------------------------------------------------------------------------
# UI Wrappers
# -----------------------------------------------------------------------------

UI_INPUT=""
UI_SELECT_PATH=""
UI_SELECT_TYPE=""
UI_CONFIRM=""
UI_NOTIFY=""

_input() {
    "$UI_INPUT" "$@"
}

_select_path() {
    "$UI_SELECT_PATH" "$@"
}

_select_project_type() {
    "$UI_SELECT_TYPE" "$@"
}

_confirm() {
    "$UI_CONFIRM" "$@"
}

_notify() {
    "$UI_NOTIFY" "$@"
}

_bind_ui() {
    case "$CURRENT_TUI" in
    1)
        UI_INPUT=_input_dialog
        UI_SELECT_PATH=_select_path_dialog
        UI_SELECT_TYPE=_select_project_type_dialog
        UI_CONFIRM=_confirm_dialog
        UI_NOTIFY=_notify_dialog
        ;;
    2)
        UI_INPUT=_input_zenity
        UI_SELECT_PATH=_select_path_zenity
        UI_SELECT_TYPE=_select_project_type_zenity
        UI_CONFIRM=_confirm_zenity
        UI_NOTIFY=_notify_zenity
        ;;
    *)
        UI_INPUT=_input_console
        UI_SELECT_PATH=_select_path_console
        UI_SELECT_TYPE=_select_project_type_console
        UI_CONFIRM=_confirm_console
        UI_NOTIFY=_notify_console
        ;;
    esac
}

# -----------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------
_show_help() {
    cat <<EOF

===============================================================================
Project Builder
===============================================================================

Interactive mode:

    ./creator.sh --dialog
    ./creator.sh --zenity
    ./creator.sh [--console]

Non-interactive mode:

    ./creator.sh <project name> <project type> <project path>

    Example:

        ./creator.sh "My project Name" "shell" "./project/My Project"

Help:

    ./creator.sh --help     - shows this help

===============================================================================

EOF
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------

main() {

    if [[ "$#" -eq 1 ]]; then
        if [[ "$1" == "--help" ]]; then
            _show_help
            exit 0
        fi
    fi

    _setup_colors

    _section "Environment checks"
    _check_not_root
    _check_os

    _parse_args "$@"

    case "$CURRENT_TUI" in
    1) _check_dependencies "dialog" ;;
    2) _check_dependencies "zenity" ;;
    esac

    _bind_ui

    local name
    local type
    local project_dir

    if [[ -z "$PROJECT_NAME" ]]; then
        _section "Interactive mode"

        while true; do
            name="$(_input "Enter project name:")"
            [[ "$name" == "" ]] && _notify "Alert" "Project name empty. Use '$DEFAULT_PROJECT_NAME'."
            name="${name:-$DEFAULT_PROJECT_NAME}"

            project_dir="$(_select_path "$DEFAULT_PROJECT_PATH")"
            [[ "$project_dir" == "" ]] && _notify "Alert" "Project path empty. Use default path!"
            project_dir="${project_dir:-$DEFAULT_PROJECT_PATH}"

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
            else
                _error "The directory already exists!"
            fi
        done

        type="$(_select_project_type)"
        type="${type:-$DEFAULT_PROJECT_TYPE}"
    else
        _section "Non-interactive mode"

        name="$PROJECT_NAME"
        type="$PROJECT_TYPE"
        project_dir="$PROJECT_PATH"
    fi

    _section "Project creation"

    _make_dir "$project_dir"
    _apply_template "$project_dir" "$type"
    _init_git "$project_dir"

    _notify "Info" "Project created at: $project_dir"
    clear

    _pass "Script completed successfully!"
}

main "$@"
