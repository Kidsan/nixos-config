{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.ffmpeg
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.sane = {
    enable = true;
  };

  programs.git = {
    enable = true;
    config = {
      http = {
        "https://git.home" = {
          sslVerify = false;
        };
      };
    };

  };


  security.polkit.enable = true;

  system.activationScripts.diff = ''
    ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
  '';

  programs.kdeconnect.enable = true;

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
    ./upgrades.nix
  ];
}
