{ ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "10:30";
    randomizedDelaySec = "10min";
    persistent = true;
    flake = "git+https://git.home/kidsan/nixos-config";
  };
}
