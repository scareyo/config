{ inputs, ... }:

{
  perSystem = { pkgs, system, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        git-crypt
        just

        inputs.home-manager.packages.${system}.default
      ];
    };

    formatter = pkgs.nixfmt-tree;
  };
}
