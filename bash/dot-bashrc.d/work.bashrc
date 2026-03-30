eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export NODE_EXTRA_CA_CERTS="/usr/local/share/ca-certificates/zscaler.crt"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
