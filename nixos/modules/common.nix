{ pkgs, config, ... }:
{
  environment.systemPackages = [
    pkgs.ffmpeg
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;


  system.activationScripts.diff = ''
    ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
  '';

  imports = [
    ./ssh.nix
    ./user.nix
    ./fonts.nix
    ./locale.nix
    ./thunar.nix
    ./pipewire.nix
    ./tailscale.nix
    ./nix-options.nix
    ./linux-kernel.nix
    ./networkmanager.nix
  ];
}
