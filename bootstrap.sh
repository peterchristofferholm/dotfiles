#!/bin/bash

curl https://mise.run | sh
eval "$(~/.local/bin/mise activate bash)"
mise install
mise exec task@latest -- task
