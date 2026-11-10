default:
  just --list

init:
  home-manager switch --flake .

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
