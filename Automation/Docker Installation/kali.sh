#!/bin/bash
# Created 09/03/2024
# Author: 05t3
# This script has been tested on Kali 2023.4

# Function to report service status and start if not running
report_and_start_service() {
    local service_name=$1
    # Check if the service is installed by checking for its unit file
    if systemctl list-unit-files | grep -qw $service_name; then
        # Service is installed, now check if it's active
        if systemctl is-active --quiet $service_name; then
            echo -e "\e[32m●\e[0m $service_name is running."
        else
            echo -e "\e[31m●\e[0m $service_name is not running. Starting it now..."
            sudo systemctl start $service_name
            # Double-check if it's now running
            if systemctl is-active --quiet $service_name; then
                echo -e "\e[32m●\e[0m $service_name has been started and is now running."
            else
                echo -e "\e[31m●\e[0m Failed to start $service_name."
            fi
        fi
    else
        echo -e "\e[31m✖\e[0m $service_name is not installed."
    fi
}

# Install Docker if not present
install_docker() {
    echo "Docker is not installed. Installing now..."
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    echo "Docker installed successfully."
}

# Install Docker Compose if not present
install_docker_compose() {
    echo "Docker Compose is not installed. Installing now..."
    download_url=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-$(uname -s)-$(uname -m) | cut -d '"' -f 4)
    if [ -z "$download_url" ]; then
        echo "Failed to fetch Docker Compose download URL."
        exit 1
    fi
    wget -q -O docker-compose "${download_url}"
    chmod +x docker-compose
    sudo mv docker-compose /usr/local/bin/docker-compose
    echo "Docker Compose installed successfully."
}

# Main script execution starts here

# Check for Docker installation and version
if command -v docker &> /dev/null; then
    echo -e "\e[32m✔\e[0m Docker is installed."
    echo "Docker version: $(docker --version)"
else
    echo -e "\e[31m✖\e[0m Docker is not installed."
fi

# Check for Docker Compose installation and version
if command -v docker-compose &> /dev/null; then
    echo -e "\e[32m✔\e[0m Docker Compose is installed."
    echo "Docker Compose version: $(docker-compose --version)"
else
    echo -e "\e[31m✖\e[0m Docker Compose is not installed."
fi

echo # Adding a newline for better readability

# Report service status and start if not running
report_and_start_service "docker.service"
report_and_start_service "docker.socket"
report_and_start_service "containerd.service"