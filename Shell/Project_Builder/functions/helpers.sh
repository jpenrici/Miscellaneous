# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------

_info() { echo -e "${CLR_INFO}[${APP_NAME}]${CLR_RESET} $*"; }
_pass() { echo -e "${CLR_OK}[OK]${CLR_RESET}   $*"; }
_warn() { echo -e "${CLR_WARN}[WARN]${CLR_RESET} $*"; }

_quit() {
    echo -e "${CLR_WARN}[Quit]${CLR_RESET} $*"
    exit 0
}

_error() {
    echo -e "${CLR_FAIL}[ERROR]${CLR_RESET} $*" >&2
    exit 1
}

_section() {
    echo
    echo -e "${CLR_SECTION}-- $* --${CLR_RESET}"
}
