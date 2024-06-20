hm:
  home-manager switch --flake .

build:
  home-manager build --flake .

gc:
  sudo nix-collect-garbage --delete-old
