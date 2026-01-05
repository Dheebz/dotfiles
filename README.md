# Dotfiles

Repository: git@github.com:Dheebz/dotfiles.git

Quick start
```bash
bash setup/run.sh
```

Use SSH for Git pushes
```bash
git remote set-url origin git@github.com:Dheebz/dotfiles.git
```

One-liner installer
```bash
curl -fsSL https://raw.githubusercontent.com/Dheebz/dotfiles/main/setup/install.sh | bash
```

Installer options
- `REPO_URL` override (defaults to this repo)
- `TARGET_DIR` defaults to `$HOME/dotfiles`

What it does
- Guided, step-by-step setup (you can skip any step when prompted)
- Installs Homebrew and packages from `macos/Brewfile`
- Installs Helix LSPs/formatters and runs `hx --health`
- Symlinks dotfiles into `$HOME`
- Ensures Git identity, Bitwarden login, env import, and SSH import
- Applies macOS tweaks, Karabiner config, and UI defaults
- Cleans up logs at the end

Project layout
- `common/` shared dotfiles by tool
- `macos/` macOS-specific setup (includes `macos/Brewfile`)
- `secure/` sensitive helpers and maps (treat as secrets)
- `setup/` install scripts

Setup steps (in order)
- `setup/00-preflight.sh` macOS, disk space, and network checks
- `setup/10-computer-name.sh` prompt for computer name
- `setup/20-xcode.sh` install Xcode CLT if missing
- `setup/30-homebrew.sh` install Homebrew
- `setup/40-brew-bundle.sh` install Brewfile packages
- `setup/45-helix-devtools.sh` install Helix LSPs/debuggers/formatters
- `setup/50-symlinks.sh` link dotfiles into `$HOME`
- `setup/55-git-identity.sh` ensure `git user.name` and `git user.email`
- `setup/60-bitwarden.sh` login/unlock Bitwarden session
- `setup/65-env.sh` import environment secrets from Bitwarden
- `setup/70-ssh.sh` import SSH keys from Bitwarden
- `setup/75-tweaks.sh` macOS quality-of-life defaults
- `setup/77-karabiner.sh` install/launch Karabiner and link config
- `setup/80-ui.sh` Dock + Finder UI setup
- `setup/90-cleanup.sh` remove logs and optional dockutil cleanup

Common flags
```bash
# Always answer yes to prompts
bash setup/run.sh --yes
```

```bash
# Skip the wizard and prompt per-step instead
bash setup/run.sh --no-wizard
```

```bash
# Stream output for long-running steps (Homebrew/Brewfile/devtools)
bash setup/run.sh --verbose
```
