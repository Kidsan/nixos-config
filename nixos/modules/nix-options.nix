{ lib
, context
, pkgs
, config
, nixpkgs
, ...
}:

{
  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.latest;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    extraOptions = /* toml */ ''
      bash-prompt = "\[nix-develop\]$ ";
      experimental-features = nix-command flakes
      auto-optimise-store = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
      keep-outputs = true
      keep-derivations = true
    '';
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  documentation.nixos.enable = false;
}
