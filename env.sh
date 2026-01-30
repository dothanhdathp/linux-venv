#!/usr/bin/bash

# Define the function for confirmation
confirm_action() {
    while true; do
        read -r -p "$1 (y/N): " response
        response=${response,,}
        case "$response" in
            [y][e][s]|[y]) 
                return 0 
                ;;
            [n][o]|[n]|"") 
                return 1 
                ;;
            *)
                echo "Invalid input. Please enter 'y' for Yes or 'n' for No."
                ;;
        esac
    done
}

setup-linux-venv() {
    if confirm_action "Do you want create a new linux-venv?"; then
        echo "Remove old python venv"
        sudo rm -rf linux-venv
    fi

    echo "Start python env"
    python3 -m venv linux-venv
    source linux-venv/bin/activate
    echo "Install requeriment"
    pip install click==8.0.4
    pip install mkdocs
    pip install pymdown-extensions
    pip install mkdocs-markmap
    pip install mkdocs-material
    pip install mkdocs_puml
    pip install mkdocs-network-graph-plugin
    pip install mkdocs-mermaid2-plugin
    deactivate
}

check-linux-venv() {
    if [[ -d "linux-venv" ]]; then
        echo "(python) linux-venv not exists."
        return 0        
    else
        return 1
    fi
}

function quick_rebuild() {
    if [[ -d "./linux-venv/" ]]; then
        ./linux-venv/bin/mkdocs build --dirty
    else
        echo "Directory does not exist. Build fail!"
    fi
}

function rebuild() {
    if [[ -d "./linux-venv/" ]]; then
        ./linux-venv/bin/mkdocs build
    else
        echo "Directory does not exist. Build fail!"
    fi
}

# case $1 in
#   "-i")
#     if [ -z $2 ]; then
#         echo Add package name \[package-name\]
#         echo env.sh -i \[package-name\]
#         exit 1
#     fi
#     python3 -m venv linux-venv
#     source linux-venv/bin/activate
#     pip install mkdocs_puml $2
#     ;;
#   "-c")
#     python3 -m venv linux-venv
#     source linux-venv/bin/activate
#     ${@:2}
#     ;;
#   "--setup")  
#     if confirm_action "Do you want create a new linux-venv?"; then
#         echo "Remove old python venv"
#         sudo rm -rf linux-venv
#     fi
#     echo "Start python env"
#     python3 -m venv linux-venv
#     source linux-venv/bin/activate
#     echo "Install requeriment"
#     pip install click==8.0.4
#     pip install mkdocs
#     pip install pymdown-extensions
#     pip install mkdocs-markmap
#     pip install mkdocs-material
#     pip install mkdocs_puml
#     pip install mkdocs-network-graph-plugin
#     pip install mkdocs-mermaid2-plugin
#     deactivate
#     ;;
#   *)
#     ;;
# esac