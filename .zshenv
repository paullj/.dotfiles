# Cargo environment
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Source local env overrides
[ -f "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"
