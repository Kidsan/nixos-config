{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
    noisetorch
    audacity
  ];

  services.easyeffects.enable = true;

  imports = [
    ./common.nix
    #    ../../programs/i3.nix
  ];

}
