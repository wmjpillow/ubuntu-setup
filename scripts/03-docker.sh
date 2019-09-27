#!/usr/bin/env bash

set -e
set -o errexit

cd $(dirname "$(realpath "$0")")/../

DOCKER_COMPOSE_VERSION="1.25.0-rc2"

# Install docker-ce
release=$(lsb_release -cs) \
 && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
 && sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $release stable" \
 && sudo apt install -y docker-ce \
 && sudo usermod -aG docker $USER

# Install docker-compose
sudo curl \
    -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` \
    -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

# Install nvidia-docker2
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
 && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
 && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list \
 && sudo apt update && sudo apt install -y nvidia-docker2

echo '{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}' | sudo tee /etc/docker/daemon.json
