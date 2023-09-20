# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ ... }:
{
  environment.persistence."/persist/system" = {
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
  fileSystems."/persist".neededForBoot = true;

  programs.fuse.userAllowOther = true; # requied for home-manager impermanence
}

