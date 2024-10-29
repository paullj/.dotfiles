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

# Add oh-my-zsh snippets
zinit snippet OMZP::command-not-found
ZSH_TMUX_AUTOSTART=true zinit snippet OMZP::tmux 

# Load oh-my-posh (as long as we're not in Apple Terminal)
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/prompt.toml)"
fi

# Key bindings
bindkey -e
# bindkey "^p" history-search-backward
# bindkey "^n" history-search-forward

# Command history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUPE=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'gls --hyperlink --color --all $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'gls --hyperlink --color $realpath'

# Aliases
alias ls='gls --hyperlink --color'

# Shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
