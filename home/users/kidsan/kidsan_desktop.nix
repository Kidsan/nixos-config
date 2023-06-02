{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
    noisetorch
    audacity
  ];

  imports = [
    ./common.nix
    ../../programs/easyeffects.nix
    #    ../../programs/i3.nix
  ];

}
