{ config, lib, pkgs, ... }:
let
  obsidian = pkgs.obsidian.override {
    electron = pkgs.electron_24.overrideAttrs (_: {
      preFixup = "patchelf --add-needed ${pkgs.libglvnd}/lib/libEGL.so.1 $out/bin/electron"; # NixOS/nixpkgs#272912
      meta.knownVulnerabilities = [ ]; # NixOS/nixpkgs#273611
    });
  };
in
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
    NIX_PATH = "nixpkgs=flake:nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
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
    obsidian
    btop
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
    ../../programs/tmux.nix
    ../../programs/nushell.nix
    ../../programs/nix-flake-templates
  ];

  # restart homeage decrypt services on home-manager change
  systemd.user.startServices = "sd-switch";

}
