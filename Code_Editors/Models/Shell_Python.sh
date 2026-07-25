#!/usr/bin/env bash
#
# ATTENTION: NON-FUNCTIONAL MODEL!
#
# =============================================================================
# QuickFix - Environment Setup & Dependency Checker
# =============================================================================
# Verifies all requirements before the application starts.
# Creates and populates the Python virtual environment if needed.
# Called automatically by run.sh — can also be run standalone.
#
# Usage:
#   ./setup.sh [--full]   - full setup
#   ./setup.sh --basic    - check environment (only)
#   ./setup.sh --plugins  - check plugins (only)
#   ./setup.sh --help     - shows this help
#
# Environment overrides (export before calling):
#   QUICKFIX_VENV=/custom/path   Override default venv location
#
# Exit codes:
#   0 - All checks passed
#   1 - One or more checks failed
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# -----------------------------------------------------------------------------
# Constants
# -----------------------------------------------------------------------------
readonly APP_NAME="QuickFix"
readonly MIN_PYTHON_MAJOR=3
readonly MIN_PYTHON_MINOR=11
readonly PLUGINS_DIR="${SCRIPT_DIR}/plugins"
readonly LOG_DIR="${HOME}/.local/share/quickfix"
readonly SETUP_LOG="${LOG_DIR}/setup.log"

# Venv location — can be overridden via environment variable before calling.
# Default: QuickFix/.venv (isolated, portable, no cross-project conflicts)
# Override example: QUICKFIX_VENV="${HOME}/.venv" ./setup.sh
readonly VENV_DIR="${QUICKFIX_VENV:-${SCRIPT_DIR}/.venv}"

# Marker file — written by setup.sh only when venv is fully ready.
# run.sh checks for this file before activating the venv.
readonly VENV_READY_MARKER="${VENV_DIR}/.quickfix_ready"

# Tracks overall result — does not abort on first failure
# so the user sees all missing dependencies at once.
FAILED=0

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

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
_pass() { echo -e "  ${CLR_OK}[OK]${CLR_RESET}   $*"; }
_warn() { echo -e "  ${CLR_WARN}[WARN]${CLR_RESET} $*"; }
_fail() {
    echo -e "  ${CLR_FAIL}[FAIL]${CLR_RESET} $*" >&2
    FAILED=1
}
_error() {
    echo -e "  ${CLR_FAIL}[ERROR]${CLR_RESET} $*" >&2
    exit 1
}
_info() { echo -e "${CLR_INFO}[${APP_NAME}]${CLR_RESET} $*"; }
_section() {
    echo
    echo -e "${CLR_SECTION}-- $* --${CLR_RESET}"
}

# -----------------------------------------------------------------------------
# Guard: refuse to run as root
# -----------------------------------------------------------------------------
_check_not_root() {
    _section "Privilege check"

    if [[ "${EUID}" -eq 0 ]]; then
        echo -e "  ${CLR_FAIL}[FAIL]${CLR_RESET} Running as root is strictly forbidden." >&2
        echo "         QuickFix and its plugins must run as a regular user." >&2
        exit 1
    fi

    _pass "Not running as root (UID=${EUID})"
}

# -----------------------------------------------------------------------------
# OS check
# -----------------------------------------------------------------------------
_check_os() {
    _section "Operating system"

    if [[ "$(uname -s)" != "Linux" ]]; then
        _fail "Linux required. Detected: $(uname -s)"
    else
        _pass "Linux $(uname -r)"
    fi
}

# -----------------------------------------------------------------------------
# System Python (used only to bootstrap the venv)
# -----------------------------------------------------------------------------
_check_system_python() {
    _section "System Python"

    if ! command -v python3 &>/dev/null; then
        _fail "python3 not found. Install Python ${MIN_PYTHON_MAJOR}.${MIN_PYTHON_MINOR}+"
        return
    fi

    local major minor
    major="$(python3 -c 'import sys; print(sys.version_info.major)')"
    minor="$(python3 -c 'import sys; print(sys.version_info.minor)')"

    if ((major < MIN_PYTHON_MAJOR || (major == MIN_PYTHON_MAJOR && minor < MIN_PYTHON_MINOR))); then
        _fail "Python ${MIN_PYTHON_MAJOR}.${MIN_PYTHON_MINOR}+ required. Found: ${major}.${minor}"
        return
    fi

    _pass "Python ${major}.${minor} at $(command -v python3)"

    # python3-venv must be available to create the venv
    if ! python3 -m venv --help &>/dev/null; then
        _fail "python3-venv module not found. Install with: sudo apt install python3-venv"
    fi
}

# -----------------------------------------------------------------------------
# Virtual environment
# -----------------------------------------------------------------------------
_setup_venv() {
    _section "Virtual environment"

    _info "Venv location: ${VENV_DIR}"

    if [[ ! -d "${VENV_DIR}" ]]; then
        _info "Creating venv..."
        python3 -m venv "${VENV_DIR}" || {
            _fail "Failed to create venv at ${VENV_DIR}"
            return
        }
        _pass "Venv created"
    else
        _pass "Venv exists"
    fi

    # Activate for the remainder of this script
    # shellcheck source=/dev/null
    source "${VENV_DIR}/bin/activate"

    # Upgrade pip silently
    pip install --quiet --upgrade pip
    _pass "pip $(pip --version | cut -d' ' -f2)"
}

# -----------------------------------------------------------------------------
# PySide6 (installed inside venv)
# -----------------------------------------------------------------------------
_check_pyside6() {
    _section "PySide6"

    if ! python -c "import PySide6" &>/dev/null; then
        _info "PySide6 not found in venv. Installing..."
        if pip install --quiet PySide6; then
            _pass "PySide6 $(python -c 'import PySide6; print(PySide6.__version__)') installed"
        else
            _fail "PySide6 installation failed. Check your internet connection."
        fi
        return
    fi

    local version
    version="$(python -c 'import PySide6; print(PySide6.__version__)')"
    _pass "PySide6 ${version}"
}

# -----------------------------------------------------------------------------
# pytest (installed inside venv)
# -----------------------------------------------------------------------------
_check_pytest() {
    _section "pytest"

    if ! python -c "import pytest" &>/dev/null; then
        _info "pytest not found in venv. Installing..."
        if pip install --quiet pytest; then
            _pass "pytest $(python -c 'import pytest; print(pytest.__version__)') installed"
        else
            _fail "pytest installation failed. Check your internet connection."
        fi
        return
    fi

    local version
    version="$(python -c 'import pytest; print(pytest.__version__)')"
    _pass "pytest ${version}"
}

# -----------------------------------------------------------------------------
# Sandbox engines
# -----------------------------------------------------------------------------
_check_sandbox() {
    _section "Sandbox"

    local found=0

    if command -v bwrap &>/dev/null; then
        _pass "bubblewrap $(bwrap --version 2>/dev/null | head -1) at $(command -v bwrap)"
        found=1
    else
        _warn "bubblewrap not found. Plugins with sandbox.required=true will be blocked."
        _warn "Install with: sudo apt install bubblewrap"
    fi

    if command -v firejail &>/dev/null; then
        _pass "firejail $(firejail --version 2>/dev/null | head -1 | awk '{print $2}') at $(command -v firejail)"
        found=1
    else
        _warn "firejail not found."
        _warn "Install with: sudo apt install firejail"
    fi

    if ((found == 0)); then
        _fail "No sandbox engine found. Install at least bubblewrap for sandboxed plugins."
    fi
}

# -----------------------------------------------------------------------------
# Required Python stdlib modules (sanity check inside venv)
# -----------------------------------------------------------------------------
_check_python_stdlib() {
    _section "Python standard library"

    local modules=("pathlib" "hashlib" "tempfile" "fcntl" "subprocess" "json" "shutil")

    for mod in "${modules[@]}"; do
        if python -c "import ${mod}" &>/dev/null; then
            _pass "${mod}"
        else
            _fail "${mod} — missing (unexpected for stdlib)"
        fi
    done
}

# -----------------------------------------------------------------------------
# Plugin dependency checks
# -----------------------------------------------------------------------------
_check_plugins() {
    _section "Plugin requirements"

    if [[ ! -d "${PLUGINS_DIR}" ]]; then
        _warn "plugins/ directory not found. Skipping plugin checks."
        return
    fi

    local plugin_count=0

    for plugin_dir in "${PLUGINS_DIR}"/*/; do
        [[ -d "${plugin_dir}" ]] || continue

        local plugin_name
        plugin_name="$(basename "${plugin_dir}")"
        local config_file="${plugin_dir}config.json"

        if [[ ! -f "${config_file}" ]]; then
            _fail "Plugin '${plugin_name}': config.json not found"
            continue
        fi

        local binaries
        binaries=$(python "${SCRIPT_DIR}/core/loader.py" --validate "${config_file}")

        for binary in ${binaries}; do
            if command -v "${binary}" &>/dev/null; then
                _pass "Plugin '${plugin_name}': ${binary} found"
            else
                _fail "Plugin '${plugin_name}': ${binary} not found — required by this plugin"
            fi
        done

        ((plugin_count++)) || true
    done

    if ((plugin_count == 0)); then
        _warn "No plugins found in ${PLUGINS_DIR}"
    else
        _pass "${plugin_count} plugin(s) scanned"
    fi
}

# -----------------------------------------------------------------------------
# Application directories
# -----------------------------------------------------------------------------
_check_directories() {
    _section "Application directories"

    local dirs=("${LOG_DIR}" "${LOG_DIR}/forensics")

    for dir in "${dirs[@]}"; do
        if [[ ! -d "${dir}" ]]; then
            mkdir -p "${dir}"
            _pass "Created: ${dir}"
        else
            _pass "Exists:  ${dir}"
        fi
    done
}

# -----------------------------------------------------------------------------
# Essential files
# -----------------------------------------------------------------------------
_check_essential_files() {
    _section "Essential files"

    local paths=(
        "cli/cli.py"
        "core/controller.py"
        "core/loader.py"
        "core/sandbox.py"
        "core/session.py"
        "core/verifier.py"
        "gui/messenger.py"
        "gui/window.py"
        "gui/worker.py")

    for path in "${paths[@]}"; do
        if [[ ! -f "${SCRIPT_DIR}/${path}" ]]; then
            _fail "Not Found: ${path}"
        else
            _pass "Exists:  ${path}"
        fi
    done
}

# -----------------------------------------------------------------------------
# Write venv ready marker (only on full success)
# -----------------------------------------------------------------------------
_write_venv_marker() {
    {
        echo "venv=${VENV_DIR}"
        echo "created=$(date --iso-8601=seconds)"
        echo "python=$(python --version 2>&1)"
        echo "pyside6=$(python -c 'import PySide6; print(PySide6.__version__)' 2>/dev/null || echo 'unavailable')"
    } >"${VENV_READY_MARKER}"
}

# -----------------------------------------------------------------------------
# Write setup log
# -----------------------------------------------------------------------------
_write_log() {
    mkdir -p "${LOG_DIR}"
    {
        echo "========================================"
        echo "QuickFix setup — $(date --iso-8601=seconds)"
        echo "User:   $(whoami) (UID=${EUID})"
        echo "Host:   $(uname -n)"
        echo "Kernel: $(uname -r)"
        echo "Venv:   ${VENV_DIR}"
        echo "Result: $( ((FAILED == 0)) && echo 'PASS' || echo 'FAIL')"
        echo "========================================"
    } >>"${SETUP_LOG}" 2>/dev/null || true
}

# -----------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------
_show_help() {
    cat <<EOF

${APP_NAME} — File manipulation through sandboxed plugins

Usage:
  ./setup.sh [--full]   - full setup
  ./setup.sh --basic    - check environment (only)
  ./setup.sh --plugins  - check plugins (only)
  ./setup.sh --help     - shows this help

Environment overrides (export before calling):
  QUICKFIX_VENV=/custom/path   Override default venv location

EOF
}

# -----------------------------------------------------------------------------
# Basic Check
# -----------------------------------------------------------------------------
_check_basic() {
    _check_os            # Application only for Linux
    _check_system_python # System python3 used only to bootstrap the venv
    _setup_venv          # Creates venv + activates for remaining checks
    _check_pyside6       # Installed inside venv
    _check_pytest        # Installed inside venv
    _check_sandbox
    _check_python_stdlib
    _check_essential_files # Important for the application to function
    _check_directories
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
    _setup_colors

    local mode="full"
    _LOG_MODE="full"

    case "${1:-}" in
    --full)
        mode="full"
        _LOG_MODE="full"
        ;;
    --basic)
        mode="basic"
        _LOG_MODE="basic"
        ;;
    --plugins)
        mode="plugins"
        _LOG_MODE="plugins"
        ;;
    --help)
        _show_help
        exit 0
        ;;
    "") mode="full" ;;
    *) _error "Unknown option: '${1}'. Use --help for usage." ;;
    esac

    _info "Checking permissions..."
    _check_not_root # Aborts immediately if root — non-negotiable

    if [[ "${mode}" == "basic" || "${mode}" == "full" ]]; then
        _info "Checking environment..."
        _check_basic
    fi

    if [[ "${mode}" == "plugins" || "${mode}" == "full" ]]; then
        _info "Checking plugins..."
        _check_plugins
    fi

    echo
    _write_log

    if ((FAILED > 0)); then
        _info "Setup ${CLR_FAIL}FAILED${CLR_RESET}. Fix the issues above before running QuickFix."
        exit 1
    fi

    _write_venv_marker
    _info "All checks passed. Environment is ${CLR_OK}ready${CLR_RESET}."
}

main "${@}"
