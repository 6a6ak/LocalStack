#!/bin/bash

# Define the Docker Desktop installer URL
DOCKER_DESKTOP_URL="https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe"

# Download the Docker Desktop installer
echo "Downloading Docker Desktop installer..."
curl -L -o DockerDesktopInstaller.exe "$DOCKER_DESKTOP_URL"

# Run the Docker Desktop installer
echo "Running Docker Desktop installer..."
./DockerDesktopInstaller.exe

# Clean up the installer after execution
echo "Cleaning up installer..."
rm DockerDesktopInstaller.exe

echo "Docker Desktop installation script has completed."
