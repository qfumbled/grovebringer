{
  description = "Grovebringer NixOS Configuration";

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      pre-commit-hooks,
      ...
    }@inputs:
    let
      outputs = self;
      mkLib = pkgs: pkgs.lib.extend (final: prev: (import ./lib final pkgs) // home-manager.lib);
      packages = nixpkgs.legacyPackages;

      mkSystem =
        {
          system ? "x86_64-linux",
          systemConfig,
          userConfigs,
          lib ? mkLib packages.${system},
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs lib;
          };
          modules = [
            { nixpkgs.hostPlatform = system; }
            systemConfig
            home-manager.nixosModules.home-manager
            inputs.impermanence.nixosModules.impermanence
            ./modules/nixos
            inputs.stylix.nixosModules.stylix
            {
              home-manager.sharedModules = [
                ./modules/home
                inputs.nixcord.homeModules.nixcord
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs outputs lib;
              };
              home-manager.users.xekuri = {
                home.stateVersion = "25.11";
                imports = [ userConfigs ];
              };
            }
          ];
        };

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      nixosConfigurations = {
        grovebringer = mkSystem {
          systemConfig = ./hosts/grovebringer;
          userConfigs = ./home/profiles/grovebringer.nix;
        };
        aureliteiron = mkSystem {
          systemConfig = ./hosts/aureliteiron;
          userConfigs = ./home/profiles/aureliteiron.nix;
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      checks = forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            deadnix = {
              enable = true;
              settings.noLambdaArg = true;
            };
            nixfmt-rfc-style.enable = true;
            statix.enable = true;
          };
        };
      });

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      });
    };

  inputs = {
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Stylix
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # Nixcord
    nixcord.url = "github:kaylorben/nixcord";
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