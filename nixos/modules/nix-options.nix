{ lib
, context
, pkgs
, config
, nixpkgs
, ...
}:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixUnstable;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    extraOptions = ''
      bash-prompt = "\[nix-develop\]$ ";
      experimental-features = nix-command flakes
      auto-optimise-store = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
      keep-outputs = true
      keep-derivations = true
    '';
  };

  documentation.nixos.enable = false;
}
