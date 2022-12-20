{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "kidsan";
  home.homeDirectory = "/home/kidsan";

  home.stateVersion = "22.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    spotify
    discord
    element-desktop
    chromium
  ];

  imports = [
    ../../programs/alacritty.nix
    ../../programs/bash.nix
    ../../programs/direnv.nix
    ../../programs/git.nix
    ../../programs/gpg.nix
    ../../programs/neovim.nix
    ../../programs/sway.nix
    ../../programs/vscode.nix
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
