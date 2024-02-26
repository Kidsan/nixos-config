{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.ffmpeg
  ];

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
    ./upgrades.nix
  ];
}
