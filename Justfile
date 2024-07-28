default:
  just --list

init:
  nix run home-manager/master -- init --switch

hm config='':
  home-manager switch --flake .{{ if config != '' { "#" + config } else { "" } }}

hm-build config='':
  home-manager build --flake .

sys:
  sudo nixos-rebuild switch --flake .

sys-build:
  sudo nixos-rebuild build --flake .

unlock:
  git-crypt unlock

lock:
  git-crypt lock

gc:
  nix-collect-garbage --delete-old
