{
  description = "Kidsan's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    homeage = {
      url = "github:jordanisaacs/homeage";
      # Optional
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets.url = "git+ssh://git@github.com/kidsan/secrets.git?ref=main";
    secrets.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, homeage, secrets, agenix, ... } @ inputs:
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
        "kidsan@thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = x86Pkgs;

          modules = [
            ./home/users/kidsan/kidsan_thinkpad.nix
            homeage.homeManagerModules.homeage
          ];
        };

        lobster = home-manager.lib.homeManagerConfiguration {
          pkgs = armPkgs;

          modules = [
            ./home/users/lobster/home.nix
          ];
        };

        "kidsan@desktop" = home-manager.lib.homeManagerConfiguration {
          pkgs = x86Pkgs;

          modules = [
            ./home/users/kidsan/kidsan_desktop.nix
            homeage.homeManagerModules.homeage
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
        buildInputs = with x86Pkgs; [
          nil
          nixpkgs-fmt
        ];
      };
    };

}
