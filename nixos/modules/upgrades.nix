{ ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "10:30";
    persistent = true;
    flake = "github:kidsan/nixos-config";
  };
}
