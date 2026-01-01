{
  description = "Your NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, pre-commit-hooks, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.grovebringer = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/grovebringer
          ./modules/nixos
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.xekuri = {
                home.stateVersion = "25.11";
                imports = [
                  ./modules/home
                  ./home/profiles/grovebringer.nix
                ];
              };
            };
          }
        ];
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

      checks.${system} = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            deadnix.enable = true;
            nixfmt.enable = true;
            statix.enable = true;
          };
        };
      };

      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
      };
    };

  nixConfig = {
    trusted-substituters = [
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
}