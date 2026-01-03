{
  description = "spilling my guts right now";

  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake Utilities
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    
    # Other Dependencies
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = [
        # maybe
      ];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        # Per-system configurations
        formatter = pkgs.nixfmt-rfc-style;

        # Dev shell with pre-commit hooks
        devShells.default = pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = with pkgs; [
            # Add any development tools here
          ];
        };

        # Pre-commit checks
        checks = {
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
        };
      };

      # Global configurations
      flake = let
        mkLib = pkgs: pkgs.lib.extend (final: prev: (import ./lib final pkgs) // inputs.home-manager.lib);

        mkSystem = {
          system ? "x86_64-linux",
          systemConfig,
          userConfigs,
          username ? "xekuri",
          lib ? mkLib inputs.nixpkgs.legacyPackages.${system},
        }:
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              outputs = self;
              inherit lib username;
            };
            modules = [
              {nixpkgs.hostPlatform = system;}
              systemConfig
              inputs.home-manager.nixosModules.home-manager
              inputs.impermanence.nixosModules.impermanence
              ./modules/nixos
              inputs.stylix.nixosModules.stylix
              {
                home-manager = {
                  sharedModules = [
                    ./modules/home
                    inputs.nixcord.homeModules.nixcord
                  ];
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit inputs;
                    outputs = self;
                    inherit lib username;
                  };
                  users.${username} = {
                    home.stateVersion = "25.11";
                    imports = [userConfigs];
                  };
                };
              }
            ];
          };
      in {
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