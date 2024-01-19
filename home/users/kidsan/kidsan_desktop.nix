{ config, lib, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    # audacity
    transcribe
  ];

  imports = [
    ./common.nix
    ../../programs/easyeffects.nix
    ../../programs/i3.nix
  ];

}
