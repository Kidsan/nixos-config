{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
  '';

  home.username = "kidsan";
  home.homeDirectory = "/home/kidsan";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    unzip
    spotify
    discord
    (element-desktop.override { electron = pkgs.electron_24; })
    nixpkgs-fmt
    jq
    weechat
    vlc
    signal-desktop
    waypipe
  ];

  imports = [
    ../../programs/alacritty.nix
    ../../programs/bash.nix
    ../../programs/direnv.nix
    ../../programs/firefox.nix
    ../../programs/fonts.nix
    ../../programs/git.nix
    ../../programs/neovim
    ../../programs/nextcloud.nix
  ];

  #  homeage = {
  # Absolute path to identity (created not through home-manager)
  #    identityPaths = [ "~/.ssh/id_ed25519" ];

  # file."foo" = {
  #   source = ../../../secrets/foo/foo.age;
  #   symlinks = [ "${config.xdg.configHome}/kidsan/foo.txt" ];
  # };
  #  };

  # restart homeage decrypt services on home-manager change
  systemd.user.startServices = "sd-switch";

}
