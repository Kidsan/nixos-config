{ config, lib, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    audacity
    kord
    transcribe
  ];

  imports = [
    ./common.nix
    ../../programs/easyeffects.nix
  ];

}
