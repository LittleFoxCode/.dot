# LFX dotfiles

These are the dotfiles I am actively using. Any dofiles I am not using get purged from the repo and are relegated to (git) history.

## Usage

Gnu Stow is used to manage the files.

### Stow dotfiles
``` bash
cd .dot/
stow --stow --dotfiles <name>
```

### Un-stow dotfiles
``` bash
cd .dot/
stow --delete --dotfiles <name>
```

### Fix broken links
``` bash
cd .dot/
stow --restow --dotfiles <name>
```
