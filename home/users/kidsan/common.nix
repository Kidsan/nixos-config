{ config, lib, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # home.activation.report-changes = config.lib.dag.entryAnywhere ''
  #   ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
  # '';

  home.username = "kidsan";
  home.homeDirectory = "/home/kidsan";

  home.sessionVariables = {
    EDITOR = "nvim";
    NIX_PATH = "nixpkgs=flake:nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
  };


  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" "chromium-browser.desktop" ];
      "x-scheme-handler/http " = [ " firefox.desktop" "chromium-browser.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" "chromium-browser.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" "chromium-browser.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" "chromium-browser.desktop" ];
    };
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
    ../../programs/tmux.nix
    ../../programs/nushell.nix
    ../../programs/nix-flake-templates
  ];

  # restart homeage decrypt services on home-manager change
  systemd.user.startServices = "sd-switch";

}
