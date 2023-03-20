{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
  noisetorch
  ];

  imports = [
  ./common.nix
  ../../programs/i3.nix
  ];

}
