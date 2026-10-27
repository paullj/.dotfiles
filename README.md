# .dotfiles

Install [Homebrew](https://brew.sh) if you do not have it

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Clone this repo into your home directory (or wherever you want)

```bash
git clone --recurse-submodules git@github.com:paullj/.dotfiles.git ~/.dotfiles
```

The tmux plugins (`tmux-resurrect`, `tmux-continuum`) are git submodules. If you
cloned without `--recurse-submodules`, get them with

```bash
git submodule update --init
```

Navigate to the .dotfiles directory

```bash
cd ~/.dotfiles
```

Install all dependencies from the `Brewfile` (each entry has a comment that says
what it is)

```bash
brew bundle
```

Run stow to symlink the files. Files listed in `.stow-local-ignore` (for
example this README and the `Brewfile`) are not linked.

```bash
stow . --target=$HOME
```

Apply the macOS settings. The script asks for your password, then restarts
Dock, Finder and SystemUIServer. Some changes need a logout or restart.

```bash
./.macos
```

## Local config

Machine-specific config stays out of git (`*.local` is in `.gitignore`):

- `~/.zshenv.local`. Private environment variables
- `~/.ssh/config.local`. Private SSH hosts. `.ssh/config` includes this file
