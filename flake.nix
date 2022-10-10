{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    # home-manager.url = "githin:nix-community/home-manager/master"
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... } @ inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
      mkSystem = import ./lib/mk_system.nix;
    in
    {

      nixosConfigurations = {
        # thinkpad = lib.nixosSystem {
        #   inherit system;

        #   modules = [
        #     ./nixos/configuration.nix
        #   ];
        # };

        desktop = lib.nixosSystem {
          inherit system;
          modules = [
            ./desktop/configuration.nix
          ];
        };

        desktop2 = mkSystem inputs "desktop" nixpkgs;

        thinkpad = mkSystem inputs "thinkpad" nixpkgs;

      };

      devShell.x86_64-linux = pkgs.mkShell {
        nativeBuildInputs = [ pkgs.bashInteractive ];
        buildInputs = [
          pkgs.nixpkgs-fmt
        ];
      };
    };

}
