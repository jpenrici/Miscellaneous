# -----------------------------------------------------------------------------
# Console UI Wrappers
# -----------------------------------------------------------------------------

_confirm_console() {
    read -rp "$1 - $2 [y/N]: " answer
    [[ "$answer" =~ ^[Yy]$ ]]
}

_notify_console() {
    echo -e "\n$1: $2\n"
}

_input_console() {
    read -rp "$1: " value
    echo "$value"
}

_select_project_type_console() {
    echo "Select project type:"
    select opt in generic cpp python shell; do
        echo "$opt"
        break
    done
}

_select_path_console() {
    read -rp "Enter project path: " path
    echo "${path:-$PWD}"
}
