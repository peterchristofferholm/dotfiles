#!/bin/bash

curl https://mise.run | sh
eval "$(~/.local/bin/mise activate bash)"
gise exec -- task bootstrap
