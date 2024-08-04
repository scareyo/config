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
