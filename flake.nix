{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    # home-manager.url = "githin:nix-community/home-manager/master"
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
    in
    {

      nixosConfigurations = {
        thinkpad = lib.nixosSystem {
          inherit system;

          modules = [
            ./nixos/configuration.nix
          ];
        };
      };
    };

}
