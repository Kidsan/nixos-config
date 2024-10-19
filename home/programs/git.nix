{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    tig
  ];

  programs.git = {
    enable = true;
    userName = "kidsan";
    userEmail = "git@kidsan.dev";
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
