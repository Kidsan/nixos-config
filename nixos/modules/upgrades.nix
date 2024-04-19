{ ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "10:30";
    randomizedDelaySec = "10min";
    persistent = true;
    flake = "github:kidsan/nixos-config";
  };
}
