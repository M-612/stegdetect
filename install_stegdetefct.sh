#!/bin/bash

# Function to install dependencies from requirements.txt
install_dependencies() {
    # Check if requirements.txt file exists
    if [[ -f "requirements.txt" ]]; then
        echo "Installing dependencies from requirements.txt..."
        
        # Read each line from requirements.txt (each line is a package)
        while read -r package; do
            if dpkg -s "$package" >/dev/null 2>&1; then
                echo "$package is already installed."
            else
                echo "Installing $package..."
                sudo apt-get install -y "$package"
            fi
        done < requirements.txt
    else
        echo "requirements.txt not found!"
        exit 1
    fi
}

# Function to download, compile, and install stegdetect
install_stegdetect() {
    echo "Downloading stegdetect source code..."
    wget https://github.com/abeluck/stegdetect/archive/refs/heads/master.zip -O stegdetect.zip
    unzip stegdetect.zip
    cd stegdetect-master || exit

    echo "Compiling stegdetect..."
    make

    echo "Installing stegdetect..."
    sudo make install

    echo "Stegdetect has been installed successfully!"

    # Clean up the downloaded files
    cd ..
    rm -rf stegdetect.zip stegdetect-master
}

# Main script execution
install_dependencies
install_stegdetect
