default:
  just --list

init:
  nix run home-manager/master -- init --switch

hm config='':
  home-manager switch --flake .{{ if config != '' { "#" + config } else { "" } }}

hm-build config='':
  home-manager build --flake .{{ if config != '' { "#" + config } else { "" } }}

sys config='':
  sudo nixos-rebuild switch --flake .{{ if config != '' { "#" + config } else { "" } }}

sys-build config='':
  nixos-rebuild build --flake .{{ if config != '' { "#" + config } else { "" } }}

unlock:
  git-crypt unlock

lock:
  git-crypt lock

gc:
  nix-collect-garbage --delete-old
