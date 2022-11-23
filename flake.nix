{
  description = "Kidsan's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];

      x86Pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
        overlays = overlays;
      };

      armPkgs = import nixpkgs {
        system = "aarch64-linux";
        config = { allowUnfree = true; };
        overlays = overlays;
      };

      lib = nixpkgs.lib;
      mkSystem = import ./lib/mk_system.nix;
      mkAarch64System = import ./lib/mk_aarch_system.nix;
    in
    {

      homeConfigurations = {
        kidsan = home-manager.lib.homeManagerConfiguration {
          pkgs = x86Pkgs;

          modules = [
            ./home/kidsan/home.nix
          ];
        };

        lobster = home-manager.lib.homeManagerConfiguration {
          pkgs = armPkgs;

          modules = [
            ./home/lobster/home.nix
          ];
        };
      };

      nixosConfigurations = {

        desktop = mkSystem inputs "desktop" nixpkgs;

        thinkpad = mkSystem inputs "thinkpad" nixpkgs;

        monster = mkAarch64System inputs "monster" nixpkgs;

      };

      devShell.x86_64-linux = x86Pkgs.mkShell {
        nativeBuildInputs = [ x86Pkgs.bashInteractive ];
        buildInputs = [
          x86Pkgs.nil
          x86Pkgs.nixpkgs-fmt
        ];
      };
    };

}
