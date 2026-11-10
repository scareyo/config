{ config, ... }:

{
  configurations.home.work = {
    system = "aarch64-darwin";
    modules = with config.flake.modules.homeManager; [
      firefox
      fonts
      git
      gpg
      nvim
      zsh
    ];
  };

  flake.modules.homeManager.work = { config, lib, pkgs, ... }:
    let
      secrets = lib.importJSON ./_secrets.json;
    in {
      home.username = secrets.username;
      home.homeDirectory = "/Users/${secrets.username}";

      home.sessionPath = [
        "${config.home.homeDirectory}/.aspire/bin"
      ];

      home.packages = with pkgs; [
        awscli2
        k9s
        kubectl
        kubernetes-helm
        nuget

        (with dotnetCorePackages; combinePackages [
          sdk_10_0
          sdk_8_0
        ])

        (writeShellApplication {
          name = "eks-update-kubeconfig";
          runtimeInputs = [
            pkgs.awscli2
            pkgs.glow
          ];
          text = ''
            usage() { echo "usage: eks-update-kubeconfig [-h] [-p <profile>] [-r <region>] [-c <cluster>]" ; }

            region=us-east-1

            while getopts "p:r:c:h:" opt; do
              case $opt in
                p)
                  profile=$OPTARG
                  ;;
                r)
                  region=$OPTARG
                  ;;
                c)
                  cluster=$OPTARG
                  ;;
                h)
                  usage
                  ;;
                *)
                  usage
                  ;;
              esac
            done

            if [ -z "$profile" ] || [ -z "$cluster" ]; then
              usage
            fi

            echo k8s - [profile="$profile", region="$region", cluster="$cluster"]

            aws sso login --profile "$profile"
            aws sts get-caller-identity --profile "$profile"
            aws eks update-kubeconfig --region "$region" --name "$cluster" --profile "$profile"
          '';
        })
      ];

      programs.git.settings.user.email = secrets.email;

      services.gpg-agent.sshKeys = [ "DDE0EEB6DE49F3E9405A1A7645DC79E77A2B9645" ];

      home.stateVersion = "24.05";
    };
}
