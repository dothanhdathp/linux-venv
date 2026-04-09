#!/usr/bin/bash

# PLANTUML_SERVER=https://www.plantuml.com/plantuml/
PLANTUML_SERVER=http://localhost:8080/svg/

# Activated Python env
active_python_env() {
	python3 -m venv linux-venv
	source linux-venv/bin/activate
}

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
    # pip install mkdocs-mermaid2-plugin
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
        ./linux-venv/bin/python3 ./linux-venv/bin/mkdocs build --dirty
    else
        echo "Directory does not exist. Build fail!"
    fi
}

function build() {
    if [ $# -eq 0 ]; then
        rm -rf ~/.config/tad-app/
        ./linux-venv/bin/python3 ./linux-venv/bin/mkdocs build
    else
        filepath=$1
        filename=$(basename $filepath)
        extension="${filename##*.}"
        echo extension=$extension
        case "$extension" in
            "yml" )
                # Rebuild all
                rm -rf ~/.config/tad-app/
                ./linux-venv/bin/python3 ./linux-venv/bin/mkdocs build
                ;;
            # "puml" )
            #     filepath_without_ext="${filename%.*}"
            #     umlfile=./docs/assets/diagram/$filepath_without_ext.puml
            #     svgfile=./docs/assets/diagram/$filepath_without_ext.svg
            #     echo Build puml diagram
            #     curl -s -H "Content-Type: text/plain; charset=UTF-8" --data-binary @$umlfile $PLANTUML_SERVER > $svgfile
            #     ;;
            * )
                ./linux-venv/bin/python3 ./linux-venv/bin/mkdocs build --dirty
                ;;
        esac
    fi
}

function diagram() {
    touch ./docs/assets/diagram/$1.puml
}

function page() {
    if [ $# -eq 0 ]; then
        echo "Usage: foreach_git <git command>"
        return 1
    fi

    for file in $*; do
        if [ -f ./docs/$file ]; then
            code ./docs/$file
        else
            touch ./docs/$file
            code ./docs/$file
        fi;
    done;
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
