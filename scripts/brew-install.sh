#!/bin/bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
exec brew install "$@"
