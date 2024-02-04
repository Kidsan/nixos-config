{ config, lib, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    # audacity
    transcribe
    gpu-screen-recorder
    xdotool
  ];

  imports = [
    ./common.nix
    ../../programs/easyeffects.nix
    ../../programs/i3.nix
  ];

}
