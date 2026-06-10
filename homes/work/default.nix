{ lib, pkgs, ... }:

let
  secrets = lib.importJSON ./secrets.json;
in {
  imports = [
    ../../modules
  ];
  
  home.username = secrets.username;
  home.homeDirectory = "/Users/${secrets.username}";

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    PATH = "$PATH:/Users/mca4114/.aspire/bin";
  };

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

  scarey.home = {
    git = {
      enable = true;
      name = "Samuel Carey";
      email = secrets.email;
    };

    gpg = {
      enable = true;
      ssh = {
        enable = true;
        pinentry = pkgs.pinentry_mac;
        keys = [ "DDE0EEB6DE49F3E9405A1A7645DC79E77A2B9645" ];
      };
    };

    firefox.enable = true;
    fonts.enable = true;
    nvim.enable = true;
    zsh.enable = true;
  };
  
  home.stateVersion = "24.05";
}
