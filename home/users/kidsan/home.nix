{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "kidsan";
  home.homeDirectory = "/home/kidsan";

  home.stateVersion = "22.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    spotify
    discord
    element-desktop
    chromium
    nixpkgs-fmt

    (stdenv.mkDerivation {
      pname = "symbols-nerd-font";
      version = "2.2.0";
      src = fetchFromGitHub {
        owner = "ryanoasis";
        repo = "nerd-fonts";
        rev = "v2.2.0";
        sha256 = "sha256-wCQSV3mVNwsA2TlrGgl0A8Pb42SI9CsVCYpVyRzF8Fg=";
        sparseCheckout = ''
          10-nerd-font-symbols.conf
          patched-fonts/NerdFontsSymbolsOnly
        '';
      };
      dontConfigure = true;
      dontBuild = true;
      installPhase = ''
        runHook preInstall

        fontconfigdir="$out/etc/fonts/conf.d"
        install -d "$fontconfigdir"
        install 10-nerd-font-symbols.conf "$fontconfigdir"

        fontdir="$out/share/fonts/truetype"
        install -d "$fontdir"
        install "patched-fonts/NerdFontsSymbolsOnly/complete/Symbols-2048-em Nerd Font Complete.ttf" "$fontdir"

        runHook postInstall
      '';
      enableParallelBuilding = true;
    })
  ];

  imports = [
    ../../programs/alacritty.nix
    ../../programs/bash.nix
    ../../programs/direnv.nix
    ../../programs/git.nix
    ../../programs/neovim
    ../../programs/sway.nix
  ];

  homeage = {
    # Absolute path to identity (created not through home-manager)
    identityPaths = [ "~/.ssh/id_ed25519" ];

    # file."foo" = {
    #   source = ../../../secrets/foo/foo.age;
    #   symlinks = [ "${config.xdg.configHome}/kidsan/foo.txt" ];
    # };
  };

  # restart homeage decrypt services on home-manager change
  systemd.user.startServices = "sd-switch";

}
