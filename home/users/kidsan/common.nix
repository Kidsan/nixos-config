{ config, pkgs, ... }:

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
    element-desktop
    nixpkgs-fmt
    jq
    weechat
    vlc
    signal-desktop
    waypipe
    # obsidian
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

  # restart homeage decrypt services on home-manager change
  systemd.user.startServices = "sd-switch";

}
