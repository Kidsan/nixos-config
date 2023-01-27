{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "kidsan";
    userEmail = "8798449+Kidsan@users.noreply.github.com";
    ignores = [
      "*.nix"
      "flake.lock"
      "!personal/**/*.nix"
      "!personal/**/flake.lock"
      "!nixos-config/**/*.nix"
      "!nixos-config/**/flake.lock"
      ".vscode/"
      ".direnv/"
    ];
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      push = { autoSetupRemote = true; };
    };
  };
}
