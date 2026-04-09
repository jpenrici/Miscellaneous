# -----------------------------------------------------------------------------
# Dialog UI Wrappers
# -----------------------------------------------------------------------------

_confirm_dialog() {
    dialog --title "$1" --yesno "$2" 0 0
}

_notify_dialog() {
    dialog --title "$1" --infobox "$2" 0 0
    sleep 2
}

_dialog_run_dialog() {
    local result
    local status

    result=$(dialog "$@" --stdout)
    status=$?

    if [[ $status -ne 0 ]]; then
        clear
        _quit "Operation cancelled"
    fi

    echo "$result"
}

_input_dialog() {
    _dialog_run_dialog --inputbox "$1" 0 0
}

_select_project_type_dialog() {
    _dialog_run_dialog \
        --title "Project Type" \
        --menu "Select project type:" \
        0 0 0 \
        generic "Generic project" \
        cpp "C++ project" \
        python "Python project" \
        shell "Shell project"
}

_select_path_dialog() {
    local initial_path="${1:-$HOME/}"

    _dialog_run_dialog \
        --title "Select project location" \
        --fselect "$initial_path" 20 70
}
