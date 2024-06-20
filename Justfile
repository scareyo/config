default:
  just --list

init:
  nix run home-manager/master -- init --switch

switch config='':
  home-manager switch --flake .{{ if config != '' { "#" + config } else { "" } }}

build config='':
  home-manager build --flake .

unlock:
  git-crypt unlock

lock:
  git-crypt lock

gc:
  nix-collect-garbage --delete-old
