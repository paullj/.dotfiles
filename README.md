# .dotfiles

To use these dotfiles, you will need the following dependencies:

- `stow`. sym-link configs
- `zoxide`. cd into recent folders
- `fzf`. fuzzy finder
- `oh-my-posh`. terminal prompt 
- `neovim`
- `eza`. better ls
- `bat`. better cat

Install dependencies with homebrew (or any other package manager)

```bash
brew install stow zoxide eza fzf bat jandedobbeleer/oh-my-posh/oh-my-posh
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
