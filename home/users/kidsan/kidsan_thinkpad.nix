{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.11";

  imports = [
    ./common.nix
    ../../programs/sway.nix
  ];
}
