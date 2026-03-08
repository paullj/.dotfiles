eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=TRUE

# Set the directory where zinit and its plugins will be installed
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Install zinit if it is not already installed
if [ ! -d "$ZINIT_HOME" ]; then
    print -P "%F{15} Installing %F{33}zinit%F{15} ZSH plugin manager…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)" && command chmod g-rwX "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# Load zinit
source "$ZINIT_HOME/zinit.zsh"

## Plugins (https://zdharma-continuum.github.io/zinit/wiki/Example-Minimal-Setup/)
# Add zsh completions
zinit ice blockf atpull'zinit creinstall -q .' wait lucid
zinit light zsh-users/zsh-completions
autoload compinit && compinit

# Add other zsh plugins
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light aloxaf/fzf-tab

# Load starship prompt (as long as we're not in Apple Terminal)
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    export STARSHIP_CONFIG=~/.config/starship/starship.toml
    eval "$(starship init zsh)"
fi

# Key bindings
bindkey -e

# Completions
setopt always_to_end                    # Move cursor to the end of a completed word
setopt auto_list                        # Automatically list choices on ambiguous completion
setopt glob_dots                        # No special treatment for file names with a leading dot

# Command history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUPE=erase
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -A $realpath'

# Aliases ls with eza if available
if command -v eza &> /dev/null; then
    alias ls='eza --hyperlink --color=always'
    alias ll='eza --hyperlink --color=always -l'
    alias lt='eza --hyperlink --color=always -T'
else
    # Fallback to default ls
    alias ls='ls --color=always'
    alias ll='ls --color=always -l'
fi

# Alias cat with bat if available
if command -v bat &> /dev/null; then
    alias cat='bat -P'
fi

alias timeout="gtimeout"

# Shell integration
eval "$(fzf --zsh)"

if command -v zoxide &>/dev/null && [[ "$CLAUDECODE" != "1" ]]; then
  zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -A $realpath'
  eval "$(zoxide init --cmd cd zsh)"
  
  # Ensure __zoxide_z function exists
  if ! type __zoxide_z &>/dev/null; then
    function __zoxide_z() {
      if [[ "$#" -eq 0 ]]; then
        builtin cd ~
      elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        builtin cd "$1"
      else
        local result
        result="$(command zoxide query --exclude "$(pwd)" -- "$@")" && builtin cd "${result}"
      fi
    }
  fi
fi


## Optional Tools

export PIPENV_VENV_IN_PROJECT=1

# cargo
. "$HOME/.cargo/env"

. "$HOME/.local/bin/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Source local env overrides (not in git)
[ -f ~/.zshenv.local ] && source ~/.zshenv.local

# Shell functions
source ~/.zsh_functions

source <(COMPLETE=zsh tms)
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
eval "$(mise activate zsh)"

fpath+=~/.zfunc; autoload -Uz compinit; compinit
