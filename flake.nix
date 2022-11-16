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
      system = "x86_64-linux";


      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = overlays;
      };

      lib = nixpkgs.lib;
      mkSystem = import ./lib/mk_system.nix;
    in
    {

      homeConfigurations = {
        kidsan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home/kidsan/home.nix
          ];
        };
      };

      nixosConfigurations = {

        desktop = mkSystem inputs "desktop" nixpkgs;

        thinkpad = mkSystem inputs "thinkpad" nixpkgs;

      };

      devShell.x86_64-linux = pkgs.mkShell {
        nativeBuildInputs = [ pkgs.bashInteractive ];
        buildInputs = [
          pkgs.rnix-lsp
        ];
      };
    };

}
