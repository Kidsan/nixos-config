{ ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    persistent = true;
    flake = "github:kidsan/nixos-config";
  };
}
