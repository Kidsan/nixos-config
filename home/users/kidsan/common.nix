{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "kidsan";
  home.homeDirectory = "/home/kidsan";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    unzip
    spotify
    discord
    element-desktop
    chromium
    nixpkgs-fmt
  ];

  imports = [
    ../../programs/alacritty.nix
    ../../programs/bash.nix
    ../../programs/direnv.nix
    ../../programs/firefox.nix
    ../../programs/fonts.nix
    ../../programs/git.nix
    ../../programs/neovim
  ];

  homeage = {
    # Absolute path to identity (created not through home-manager)
    identityPaths = [ "~/.ssh/id_ed25519" ];

    # file."foo" = {
    #   source = ../../../secrets/foo/foo.age;
    #   symlinks = [ "${config.xdg.configHome}/kidsan/foo.txt" ];
    # };
  };

  # restart homeage decrypt services on home-manager change
  systemd.user.startServices = "sd-switch";

}
