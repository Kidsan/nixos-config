{ pkgs, lib, config, ... }:
let
  host = config.networking.hostName;
in
lib.mkMerge [
  (lib.mkIf (host == "desktop") {
    boot.kernelPackages = pkgs.linuxPackages_6_10;
  })
  (lib.mkIf (host != "desktop") {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  })
]
