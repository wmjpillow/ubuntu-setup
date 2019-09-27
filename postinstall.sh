#!/usr/bin/env bash

set -e
set -o errexit

export DEBIAN_FRONTEND=noninteractive

bash -i ./scripts/02-utils.sh && source ~/.bashrc
bash -i ./scripts/03-docker.sh && source ~/.bashrc
bash -i ./scripts/04-cmake.sh && source ~/.bashrc
bash -i ./scripts/05-node.sh && source ~/.bashrc
bash -i ./scripts/06-vscode.sh && source ~/.bashrc
bash -i ./scripts/07-slack.sh && source ~/.bashrc
bash -i ./scripts/08-gnome-shell.sh && source ~/.bashrc
