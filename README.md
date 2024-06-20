# config

These are my personal dotfiles managed by home-manager

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

4. Switch to the desired home configuration

```
just switch [config]
```
