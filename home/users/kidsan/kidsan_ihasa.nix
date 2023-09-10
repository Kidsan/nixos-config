{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.11";

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

  imports = [
    ../../programs/bash.nix
    ../../programs/git.nix
    ../../programs/neovim
    ../../programs/sway.nix
    ../../programs/fonts.nix
    ../../programs/alacritty.nix
  ];

  wayland.windowManager.sway.config.modifier = lib.mkForce "Mod4";
  wayland.windowManager.sway.config.startup = lib.mkForce [];
  wayland.windowManager.sway.config.input = lib.mkForce {
   "1452:641:Apple_Internal_Keyboard_/_Trackpad" = {
    xkb_layout = "gb,us";
    xkb_variant = ",dvp";
    xkb_options = "caps:escape,compose:ralt,grp:ctrls_toggle";
   };
  };
  services.kanshi.enable = lib.mkForce false;

  wayland.windowManager.sway.extraConfig = ''
    output Unknown-1 scale 2
  '';
}
