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

export AUTOSWITCH_SILENT=TRUE && zinit wait lucid for michaelaquilina/zsh-autoswitch-virtualenv

# Add oh-my-zsh snippets
zinit snippet OMZP::command-not-found
export ZSH_TMUX_AUTOSTART=TRUE && zinit snippet OMZP::tmux

# Load oh-my-posh (as long as we're not in Apple Terminal)
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/prompt.toml)"
fi

# Key bindings
bindkey -e
bindkey '\e[1;9D' beginning-of-line     # cmd+left
bindkey '\e[1;9C' end-of-line           # cmd+right
bindkey '\e[1;9Z' undo                  # cmd+z
bindkey '\e[1;10Z' redo                 # cmd+shift+z
bindkey '\e[3;9~' backward-kill-line    # cmd+backspace
# bindkey "^p" history-search-backward
# bindkey "^n" history-search-forward

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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'gls --hyperlink --color --all $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'gls --hyperlink --color $realpath'

# Aliases
alias ls='gls --hyperlink --color'
alias vim='nvim'
# Shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
