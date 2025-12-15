Dheebz dotfiles
=================

Bootstrap one-liners
---------------------

Run the bootstrap directly (downloads and executes the script):

```bash
curl -fsSL https://raw.githubusercontent.com/Dheebz/dotfiles/main/bootstrap.sh | bash -s --
```

Safer (download, inspect, then run):

```bash
curl -fsSL -o /tmp/bootstrap.sh https://raw.githubusercontent.com/Dheebz/dotfiles/main/bootstrap.sh
less /tmp/bootstrap.sh   # inspect the script
bash /tmp/bootstrap.sh
```

Notes:
- The script will link files from the repository into your home directory by default (backups are created in `$XDG_STATE_HOME/dotfiles_backup`).
- To skip dotfile cloning and instead link files from the local copy, set `DOTFILES_REPO=` when running the script.

