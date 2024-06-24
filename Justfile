switch flake='':
  nix registry add flake:config $(pwd)
  home-manager switch --flake {{ if flake == '' { "." } else { "./external/" + flake } }}

build flake='':
  nix registry add flake:config $(pwd)
  home-manager build --flake {{ if flake == '' { "." } else { "./external/" + flake } }}

gc:
  sudo nix-collect-garbage --delete-old
