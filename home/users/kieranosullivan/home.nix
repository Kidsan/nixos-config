{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "22.11";
  home.username = "kieranosullivan";
  home.homeDirectory = "/home/kieranosullivan";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    nixpkgs-fmt
  ];

  imports = [
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
