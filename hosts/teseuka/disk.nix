{ self, ... }:

{
  imports = [
    self.inputs.disko.nixosModules.disko
  ];

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/disk/by-id/nvme-ADATA_SX8200PNP_2J3420170472";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          type = "EF00";
          size = "4G";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        root = {
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/@" = {
                mountpoint = "/";
              };
              "/@home" = {
                mountpoint = "/home";
                mountOptions = [
                  "compress=zstd"
                ];
              };
              "/@nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
              "/@swap" = {
                mountpoint = "/swap";
                swap = {
                  swapfile.size = "32G";
                };
              };
            };
          };
        };
      };
    };
  };
}
