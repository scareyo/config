{
  flake.overlays.default = final: prev: {
    push-to-talk = final.callPackage ./_pkgs/push-to-talk.nix { };
  };
}
