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

case $1 in
  "-i")
    if [ -z $2 ]; then
        echo Add package name \[package-name\]
        echo env.sh -i \[package-name\]
        exit 1
    fi
    python3 -m venv linux-venv
    source linux-venv/bin/activate
    pip install mkdocs_puml $2
    ;;
  "-c")
    python3 -m venv linux-venv
    source linux-venv/bin/activate
    ${@:2}
    ;;
  *)
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
    ;;
esac