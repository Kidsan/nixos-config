{ ... }:
{
  imports = [
    ./ssh.nix
    ./user.nix
    ./fonts.nix
    ./locale.nix
    ./thunar.nix
    ./weechat.nix
    ./pipewire.nix
    ./tailscale.nix
    ./nix-options.nix
    ./linux-kernel.nix
    ./networkmanager.nix
  ];
}
