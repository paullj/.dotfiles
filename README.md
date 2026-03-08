# .dotfiles

To use these dotfiles, you will need the following dependencies:

- `stow`. sym-link configs
- `zoxide`. cd into recent folders
- `fzf`. fuzzy finder
- `ripgrep`. better grep
- `fd`. better find:
- `starship`. terminal prompt 
- `neovim`. text editor
- `eza`. better ls
- `bat`. better cat
- `tmux`. terminal multiplexer
- `tmux-sessionizer`. tmux session management

Install dependencies with homebrew (or any other package manager)

```bash
brew install stow zoxide fzf ripgrep fd starship neovim eza bat tmux tmux-sessionizer
```

Clone this repo into your home directory (or wherever you want)

```bash
git clone git@github.com:paullj/.dotfiles.git ~/.dotfiles
```

Navigate to the .dotfiles directory

```bash
cd ~/.dotfiles
```

Run stow to symlink the files

```bash
 stow . --target=$HOME
```
