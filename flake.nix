{
  description = "Kidsan's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos.url = "nixpkgs/nixos-unstable";

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

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    secrets.url = "git+ssh://git@github.com/kidsan/secrets.git?ref=main";
    secrets.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixos, home-manager, homeage, secrets, agenix, darwin, ... } @ inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        (import ./overlays/weechat.nix)
      ];

      x86Pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
        inherit overlays;
      };

      armPkgs = import nixpkgs {
        system = "aarch64-linux";
        config = { allowUnfree = true; };
        inherit overlays;
      };

      darwinPkgs = import nixpkgs {
        system = "aarch64-darwin";
        config = { allowUnfree = true; };
      };

    in
    {
      homeConfigurations = {
        "kidsan@thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = x86Pkgs;

          modules = [
            ./home/users/kidsan/kidsan_thinkpad.nix
            homeage.homeManagerModules.homeage

            # https://ayats.org/blog/channels-to-flakes/
            (args: {
              xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
              home.sessionVariables.NIX_PATH = "nixpkgs=${args.config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
            })

            { nix.registry.nixpkgs.flake = nixpkgs; }
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
            # https://ayats.org/blog/channels-to-flakes/
            (args: {
              xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
              home.sessionVariables.NIX_PATH = "nixpkgs=${args.config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
            })

            { nix.registry.nixpkgs.flake = nixpkgs; }
          ];
        };

        "kieranosullivan@Kierans-Air" = home-manager.lib.homeManagerConfiguration {
          pkgs = darwinPkgs;

          modules = [
            ./home/users/kieranosullivan/home.nix
            homeage.homeManagerModules.homeage
          ];
        };
      };

      nixosConfigurations = {

        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              ./nixos/desktop.nix
              agenix.nixosModules.default
              secrets.nixosModules.desktop or { }
              {
                environment.etc."nix/inputs/nixpkgs".source = inputs.nixos.outPath;
              }
              ./lib/cachix.nix
              ./nixos/modules/common.nix
              ./nixos/modules/kde.nix
              ./nixos/modules/steam.nix
            ];
        };

        thinkpad = nixpkgs.lib.nixosSystem
          {
            system = "x86_64-linux";
            modules = [
              agenix.nixosModules.default
              secrets.nixosModules.thinkpad or { }
              {
                environment.etc."nix/inputs/nixpkgs".source = inputs.nixos.outPath;
              }
              ./nixos/thinkpad.nix
              ./lib/cachix.nix
              ./nixos/modules/common.nix
              ./nixos/modules/xdg.nix
            ];
          };

        monster = nixpkgs.lib.nixosSystem
          {
            system = "aarch64-linux";
            modules = [
              ./nixos/monster.nix
              ./nixos/modules/home-assistant.nix
            ];
          };
      };

      darwinConfigurations = {
        "Kierans-Air" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inputs = { inherit darwin nixpkgs; };
          pkgs = darwinPkgs;
          modules = [
            ./darwin/macbook.nix
          ];
        };
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
