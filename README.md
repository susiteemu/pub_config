# This repository contains all of my workstation public configurations

## Installation

Clone this repository into `~/repositories/pub_config`. If you do otherwise, change the paths below to match your cup of tea!

## bat

### Installation

`brew install bat`

#### Catppuccin-mocha theme Installation

See [Catppuccin's bat Github](https://github.com/catppuccin/bat)

## delta

### Pre-requirements

- This repository cloned into `~/repositories/pub_config`
- `bat` and Catppuccin-mocha theme installed.

### Installation

`brew install git-delta`

### Configuration

Add following to `~/.gitconfig`:
```
[include]
    path = ~/repositories/pub_config/delta/themes.gitconfig

[delta]
    features = felix-mocha
```

## lazygit

### Installation

`brew install lazygit`

### Configuration

Make symlink from `~/repositories/pub_config/lazygit/config.yml` to `~/.config/lazygit/config.yml`

`ln -s ~/repositories/pub_config/lazygit/config.yml ~/.config/lazygit/config.yml`

Make sure `~/.config/` is in `XDG_CONFIG_HOME`. Do this by adding the following export to your `fish` config:

`set -gx XDG_CONFIG_HOME $HOME/.config`
