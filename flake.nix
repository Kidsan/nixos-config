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
      # inputs.neovim-flake.url = "github:neovim/neovim?dir=contrib&rev=b641fc38749a2a52e40fa7eca6c7c41b1d9b031c";
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


    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";


    impermanence.url = "github:nix-community/impermanence/master";

    disko.url = "github:nix-community/disko/master";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos, home-manager, homeage, agenix, darwin, deploy-rs, impermanence, disko, ... } @ inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        (import ./overlays/weechat.nix)
      ];

      config = { allowUnfree = true; };

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

      deployPkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [
          deploy-rs.overlay
          (self: super: {
            deploy-rs = {
              pkgs = x86Pkgs;
              inherit deploy-rs;
              lib = super.deploy-rs.lib;
            };
          })
        ];
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

          modules = [ ];
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
              ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
              ./nixos/desktop.nix
              disko.nixosModules.disko
              impermanence.nixosModule
              agenix.nixosModules.default
              {
                environment.etc."nix/inputs/nixpkgs".source = inputs.nixos.outPath;
              }
              home-manager.nixosModules.home-manager
              {
                nixpkgs.overlays = overlays;
                home-manager.useGlobalPkgs = true;
                home-manager.users.kidsan = { pkgs, ... }: {
                  imports = [
                    ./home/users/kidsan/kidsan_desktop.nix
                    impermanence.nixosModules.home-manager.impermanence
                  ];
                  xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
                  nix.registry.nixpkgs.flake = nixpkgs;
                };
              }
            ];
        };

        thinkpad = nixpkgs.lib.nixosSystem
          {
            system = "x86_64-linux";
            modules = [
              agenix.nixosModules.default
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
              agenix.nixosModules.default
              ./nixos/modules/ssh.nix
              ./nixos/monster.nix
              ./nixos/modules/home-assistant.nix
            ];
          };
      };

      darwinConfigurations = {
        "Kierans-Air" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inputs = { inherit darwin nixpkgs; };
          pkgs = import nixpkgs {
            inherit config;
            system = "aarch64-darwin";
          };
          modules = [
            ./darwin/macbook.nix
          ];
        };
      };

      deploy.nodes.thinkpad = {
        hostname = "192.168.2.113";
        fastConnection = true;
        sshUser = "kidsan";
        sshOpts = [ "-t" ];
        # profiles.system = {
        #   user = "root";
        #   path = deployPkgs.deploy-rs.lib.activate.nixos self.nixosConfigurations.thinkpad;
        # };
        profiles.home = {
          user = "kidsan";
          path = deployPkgs.deploy-rs.lib.activate.home-manager self.homeConfigurations."kidsan@thinkpad";
          profilePath = "/nix/var/nix/profiles/per-user/kidsan/profile";
        };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

      devShell.x86_64-linux = x86Pkgs.mkShell {
        nativeBuildInputs = [ x86Pkgs.bashInteractive ];
        buildInputs = with x86Pkgs; [
          nil
          nixpkgs-fmt
        ];
      };
    };

}
