{
  description = "Kidsan's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos.url = "nixpkgs/nixos-unstable";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";

    impermanence.url = "github:nix-community/impermanence/63f4d0443e32b0dd7189001ee1894066765d18a5";

    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/master";

    secrets.inputs.nixpkgs.follows = "nixpkgs";
    secrets.url = "git+ssh://forgejo@git.home/kidsan/secrets.git?ref=main";

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";

    waybar.url = "github:Alexays/waybar";

    rippkgs.url = "github:replit/rippkgs";
    rippkgs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-wayland, nixos, home-manager, secrets, agenix, impermanence, disko, waybar, rippkgs, ... } @ inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
        (import ./overlays/weechat.nix)
        (import ./overlays/transcribe.nix)
        inputs.nixpkgs-wayland.overlays.default
        inputs.waybar.overlays.default

        (self: super: {
          vulkan-validation-layers = super.vulkan-validation-layers.overrideAttrs (old: {
            buildInputs = old.buildInputs ++ [ super.spirv-tools ];
          });
          swayidle = super.swayidle.overrideAttrs (old: {
            nativeBuildInputs = old.nativeBuildInputs ++ [ super.cmake ];
            buildInputs = old.buildInputs ++ [ super.wayland-scanner ];
          });
        })
      ];

      config = {
        allowUnfree = true;
      };

      nixosPackages = import nixos {
        system = "x86_64-linux";
        inherit config overlays;
      };

      x86Pkgs = import nixpkgs {
        system = "x86_64-linux";
        inherit config overlays;
      };

      armPkgs = import nixpkgs {
        system = "aarch64-linux";
        config = { allowUnfree = true; allowUnsupportedSystem = true; };
        inherit overlays;
      };

    in
    {
      homeConfigurations = { };

      nixosConfigurations = {
        desktop = nixos.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = nixosPackages;
          modules =
            [
              ./nixos/desktop.nix
              disko.nixosModules.disko
              impermanence.nixosModule
              agenix.nixosModules.default
              {
                nix.nixPath = [ "nixpkgs=flake:nixpkgs" ];
              }
              secrets.nixosModules.desktop or { }
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  pkgs = x86Pkgs;
                };
                home-manager.users.kidsan = import ./home/users/kidsan/kidsan_desktop.nix;
                home-manager.backupFileExtension = "backup";
              }
              ({ pkgs, ... }: {
                environment.systemPackages = [
                  inputs.rippkgs.packages.${pkgs.system}.rippkgs
                  inputs.rippkgs.packages.${pkgs.system}.rippkgs-index
                ];
              })
            ];
        };

        thinkpad = nixos.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = nixosPackages;
          modules = [
            agenix.nixosModules.default
            {
              environment.etc."nix/inputs/nixpkgs".source = inputs.nixos.outPath;
            }
            ./nixos/thinkpad.nix
            secrets.nixosModules.thinkpad or { }
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                pkgs = x86Pkgs;
              };
              home-manager.users.kidsan = import ./home/users/kidsan/kidsan_thinkpad.nix;
            }
          ];
        };

        monster = nixos.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            agenix.nixosModules.default
            ./nixos/monster.nix
            secrets.nixosModules.monster or { }
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                pkgs = armPkgs;
              };
              home-manager.users.lobster = import ./home/users/lobster/home.nix;
            }
          ];
        };

        pachinko = nixos.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = nixosPackages;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            agenix.nixosModules.default
            disko.nixosModules.disko
            ./nixos/pachinko.nix
            secrets.nixosModules.pachinko or { }
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                pkgs = x86Pkgs;
              };
              home-manager.users.kidsan = import ./home/users/pachinko.nix;
            }
          ];
        };
      };

      devShell.x86_64-linux = x86Pkgs.mkShell
        {
          nativeBuildInputs = [ x86Pkgs.bashInteractive ];
          buildInputs = with x86Pkgs; [
            nil
            nixpkgs-fmt
          ];
        };
    };

}
