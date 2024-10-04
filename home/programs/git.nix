{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    tig
  ];

  programs.git = {
    enable = true;
    userName = "kidsan";
    userEmail = "8798449+Kidsan@users.noreply.github.com";
    ignores = [
      ".direnv/"
      ".go/"
    ];
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      push = { autoSetupRemote = true; };
      merge = { conflictstyle = "diff3"; };
      http = {
        "https://git.home" = {
          sslVerify = false;
        };
      };
    };
  };
}
