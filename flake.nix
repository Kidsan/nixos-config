{
  description = "Kidsan's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    homeage = {
      url = "github:jordanisaacs/homeage";
      # Optional
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, homeage, agenix, nixos-generators, ... } @ inputs:
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
    rec {
      homeConfigurations = {
        kidsan = home-manager.lib.homeManagerConfiguration {
          pkgs = x86Pkgs;

          modules = [
            ./home/users/kidsan/home.nix
            homeage.homeManagerModules.homeage
          ];
        };

        lobster = home-manager.lib.homeManagerConfiguration {
          pkgs = armPkgs;

          modules = [
            ./home/users/lobster/home.nix
          ];
        };
      };

      nixosConfigurations = {

        desktop = mkSystem inputs "desktop" nixpkgs;

        thinkpad = mkSystem inputs "thinkpad" nixpkgs;

        monster = mkAarch64System inputs "monster" nixpkgs;

        basePi = nixpkgs.lib.nixosSystem {
          system = "armv7l-linux";
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
            {
              nixpkgs.config.allowUnsupportedSystem = true;
              nixpkgs.crossSystem.system = "armv7l-linux";
            }
            ./nixos/base_pi.nix
          ];
        };
      };

      images.basePi = nixosConfigurations.basePi.config.system.build.sdImage;

      devShell.x86_64-linux = x86Pkgs.mkShell {
        nativeBuildInputs = [ x86Pkgs.bashInteractive ];
        buildInputs = with x86Pkgs; [
          nil
          nixpkgs-fmt
          agenix.defaultPackage.x86_64-linux
        ];
      };
    };

}
