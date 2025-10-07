#!/bin/bash

sudo apt update
sudo apt install build-essential

curl https://mise.run | sh
eval "$(~/.local/bin/mise activate bash)"
mise install
mise exec task@latest -- task
