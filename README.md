# config

These are my personal dotfiles and system configurations

## Setup

1. Enter dev shell

```
nix develop
```

2. Initialize home-manager

```
just init
```

3. (optional) Unlock secrets

```
just unlock
```

### System

Switch to the desired system configuration

```
just sys [config]
```

### Home

Switch to the desired home configuration

```
just hm [config]
```

## Layout

This flake follows the [dendritic pattern](https://github.com/mightyiam/dendritic):
every `.nix` file under `modules/` is a [flake-parts](https://flake.parts) module,
loaded automatically with [import-tree](https://github.com/vic/import-tree).
Paths containing `/_` are skipped, so helper files are prefixed with `_`.

- `modules/flake/` holds flake plumbing: flake-parts setup, option declarations
  and the dev shell.
- `modules/<category>/<feature>.nix` (`browsers`, `desktop`, `editors`, `shell`,
  `system`) defines `flake.modules.homeManager.<feature>` and/or
  `flake.modules.nixos.<feature>`. Importing a feature enables it.
  `modules/base.nix` is shared by every home.
- `modules/hosts/<host>/` defines each host's own module
  (`flake.modules.homeManager.<name>`) and declares the configuration:
  ```nix
  configurations.home."scarey@vegapunk" = {
    system = "aarch64-darwin";
    modules = with config.flake.modules.homeManager; [ firefox git zsh ];
  };
  ```
  `modules/flake/home-configurations.nix` builds `homeConfigurations.<name>` from
  this, always importing the host's own module and `base`. teseuka's
  `nixosConfigurations` entry is defined directly in `hosts/teseuka/nixos.nix`.
