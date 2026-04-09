# -----------------------------------------------------------------------------
# Zenity UI Wrappers
# -----------------------------------------------------------------------------

_confirm_zenity() {
    zenity \
        --question \
        --title="$1" \
        --text="$2"

    return $? # importante: mantém comportamento booleano
}

_notify_zenity() {
    zenity \
        --info \
        --title="$1" \
        --text="$2"
}

_input_zenity() {
    local result
    result=$(zenity --entry --title="Input" --text="$1")

    if [[ $? -ne 0 ]]; then
        _error "Input cancelled"
    fi

    echo "$result"
}

_select_project_type_zenity() {
    local result

    result=$(zenity \
        --list \
        --title="Project Type" \
        --column="Type" \
        generic \
        cpp \
        python \
        shell \
        --height=300 \
        --width=300)

    if [[ $? -ne 0 ]]; then
        _error "Selection cancelled"
    fi

    echo "$result"
}

_select_path_zenity() {
    local initial_path="${1:-$HOME}"
    local result

    result=$(zenity \
        --file-selection \
        --directory \
        --title="Select project location" \
        --filename="$initial_path/")

    if [[ $? -ne 0 ]]; then
        _error "Path selection cancelled"
    fi

    echo "$result"
}
