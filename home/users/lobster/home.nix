{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "lobster";
  home.homeDirectory = "/home/lobster";

  home.stateVersion = "20.09";

  home.packages = with pkgs; [

  ];

  imports = [
    ../../programs/direnv.nix
    ../../programs/git.nix
  ];
}
