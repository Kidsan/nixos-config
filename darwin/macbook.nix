{pkgs, ... }:
{
  environment.systemPackages = [
      pkgs.vim
  ];

  documentation.enable = false;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  programs.zsh.enable = true;
  programs.zsh.promptInit = "";
  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    experimental-features = nix-command flakes
  '';
}
