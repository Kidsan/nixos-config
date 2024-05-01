{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "22.11";
  home.username = "kieranosullivan";
  home.homeDirectory = "/Users/kieranosullivan";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    nixpkgs-fmt
  ];

  imports = [
    ../../programs/neovim
    ../../programs/nushell.nix
  ];

}
