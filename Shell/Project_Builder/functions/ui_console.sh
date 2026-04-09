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
    read -rp "$1 " value
    echo "$value"
}

_select_project_type_console() {
    local opt
    PS3="Choose project type: "

    echo "Select project type:" >&2

    select opt in "${TEMPLATES[@]}"; do
        if [[ -n "$opt" ]]; then
            echo "$opt"
            break
        else
            echo "Invalid option" >&2
        fi
    done
}

_select_path_console() {
    read -rp "Enter project path: " path
    echo "$path"
}
