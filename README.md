# Dheebz Dotfiles

A clean, modular macOS dotfiles setup designed to bootstrap a new system in minutes.

This repo includes configuration for:

- **Shell** (zsh)
- **Neovim**
- **WezTerm**
- **Starship** prompt
- **Git**
- Developer CLI tools (fzf, ripgrep, fd, etc.)
- JetBrains Mono Nerd Font
- A `~/Workspace` directory with QoL helpers

Everything is handled by one script:

```
./install.sh
```

It installs Homebrew, CLI tools, casks, fonts, creates `~/Workspace`, and symlinks all configs.


---

## ⚡ One-line install (curl only)

If you have **only `curl`**, use this:

```bash
/bin/bash -c 'cd "$HOME" && \
  curl -L https://github.com/Dheebz/dotfiles/archive/refs/heads/main.zip -o dotfiles.zip && \
  unzip -q dotfiles.zip && rm dotfiles.zip && \
  mv dotfiles-main .dotfiles && \
  cd .dotfiles && chmod +x install.sh && ./install.sh'
```

This will:

1. Download the repo
2. Unzip it
3. Move it to `~/.dotfiles`
4. Run `install.sh`

After it finishes, open a **new terminal window**.


---

## 🧰 What `install.sh` does

The installer is idempotent — safe to re-run anytime.

It performs:

1. Install Xcode Command Line Tools
2. Install Homebrew
3. Install CLI tools
4. Install GUI apps
5. Install Nerd Font
6. Ensure `~/Workspace` exists
7. Symlink all dotfiles
8. Backup existing conflicting files (`*.backup.<timestamp>`)


### Symlinks created:

```
shell/.zshrc                 → ~/.zshrc
nvim/                        → ~/.config/nvim
wezterm/.wezterm.lua         → ~/.wezterm.lua
starship/starship.toml       → ~/.config/starship.toml
git/.gitconfig               → ~/.gitconfig
git/.gitignore_global        → ~/.gitignore_global
```


---

## 🔧 Script modes

```
./install.sh               # Full install
./install.sh --link-only   # Symlinks only + ensure ~/Workspace
./install.sh --brew-only   # Install Homebrew + packages + ensure ~/Workspace
```


---

## 📂 Directory layout

```
~/.dotfiles/
  install.sh

  shell/
    .zshrc

  nvim/
    init.lua
    lua/...

  wezterm/
    .wezterm.lua

  starship/
    starship.toml

  git/
    .gitconfig
    .gitignore_global

  fonts/
    install.sh
```


---

## 🧠 Shell behaviour (`.zshrc` highlights)

The managed `~/.zshrc` provides:

- Homebrew env setup
- `WORKSPACE="$HOME/Workspace"` + `cwork` alias
- Rich shell history (timestamps, shared)
- Case-insensitive enhanced completion
- Starship prompt
- fzf + nvm integration
- Optional replacements if installed:
  - `eza` → ls
  - `bat` → cat
  - `zoxide` with `c` alias
- Git aliases (`gs`, `gp`, `gco`, `gcb`, etc.)
- `mkcd` and `cproj` helpers


### 🔥 Auto-virtualenv in `~/Workspace`

When you `cd` into a directory under `~/Workspace` that contains:

- `.venv`
- `.env`
- `venv`
- `env`

…it automatically:

- activates the environment
- switches environments when you change directories
- deactivates when leaving `~/Workspace`


---

## 🔁 Updating dotfiles

```bash
cd ~/.dotfiles
git pull
./install.sh
```


---

## ✔️ Done!

Open a new terminal window and enjoy a clean, fully bootstrapped macOS dev environment.

