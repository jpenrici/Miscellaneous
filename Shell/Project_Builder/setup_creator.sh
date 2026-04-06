#!/usr/bin/env bash

set -euo pipefail # global guard

# Reference path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# -----------------------------------------------------------------------------
# Constants
# -----------------------------------------------------------------------------
readonly APP_NAME="Project_Builder"
readonly LOG_DIR="${HOME}/.local/share/${APP_NAME}"
readonly SETUP_LOG="${LOG_DIR}/setup_creator.log"
readonly COMMON_FUNCTIONS="${SCRIPT_DIR}/functions"

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------
source "${COMMON_FUNCTIONS}/color.sh"
source "${COMMON_FUNCTIONS}/helpers.sh"
source "${COMMON_FUNCTIONS}/guard.sh"
source "${COMMON_FUNCTIONS}/os_check.sh"
source "${COMMON_FUNCTIONS}/dependencies_check.sh"
source "${COMMON_FUNCTIONS}/directories_check.sh"

# -----------------------------------------------------------------------------
# Display
# -----------------------------------------------------------------------------
_question() {
    if [[ -z "$1" ]]; then
        return
    fi
    if zenity --question --text="$1"; then
        zenity --notification --window-icon="info" --text="Test..." # Test
    else
        zenity --warning --text="Test!!!" # Test
    fi
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
    _setup_colors

    _section "Privilege check"
    _check_not_root

    _section "Operating system"
    _check_os

    _section "Dependencies check"
    _check_dependencies "zenity curl"

    _section "Directories check"
    _check_directories "${LOG_DIR}"

    _question "Add the 'src' directory?"
}

main # no entry argument
