### .dotfiles

To use these dotfiles, you will need to install the following dependencies:

- stow
- coreutils
- zoxide
- fzf
- oh-my-posh
- tmux

Install dependencies with homebrew (or any other package manager)

```
brew install stow coreutils zoxide fzf tmux jandedobbeleer/oh-my-posh/oh-my-posh
```

Clone this repo into your home directory

```
git clone git@github.com:paullj/.dotfiles.git ~/.dotfiles
```

Navigate to the .dotfiles directory

```
cd ~/.dotfiles
```

Run stow to symlink the files

```
stow .
```

#### TODO

- Make cmd+z undo redo work
- Short cut for go to beginning of line and end of line
- Short cut for deleting a whole line