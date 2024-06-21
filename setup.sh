#!/bin/bash

if [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    echo "This script cannot be run on Windows."
    echo "Please follow the installation instructions at https://docs.python.org/3/using/windows.html"
    echo "To install poetry on Windows, please follow the instructions at https://python-poetry.org/docs/master/#installation"
    
    exit 1
else
    if ! command -v python3 &> /dev/null
    then
        echo "python3 could not be found"
        echo "Installing python3 using pyenv..."
        if ! command -v pyenv &> /dev/null
        then
            echo "pyenv could not be found"
            echo "Installing pyenv..."
            curl https://pyenv.run | bash
        fi
        pyenv install 3.11.5
        pyenv global 3.11.5
    fi

    if ! command -v poetry &> /dev/null
    then
        echo "poetry could not be found"
        echo "Installing poetry..."
        curl -sSL https://install.python-poetry.org | python3 -
        export PATH="/home/ubuntu/.local/bin:$PATH"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    fi   

    if ! command -v pip3 &> /dev/null
    then
        echo "pip3 could not be found"
        echo "Installing pip3..."
        sudo apt-get update -y

        sudo apt-get install python3-pip
        pip3 install uvicorn
        cd autogpt/setup 
        POETRY_INSTALLER_PARALLEL=false
        poetry install --no-interaction --extras benchmark
        cd ../../
        cd rnd/autogpt_server
        poetry install --no-interaction
    fi
fi
