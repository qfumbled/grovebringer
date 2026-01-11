{
  description = "spilling my guts right now";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      inputs = {};
    };

    systems = {
      url = "github:nix-systems/default-linux";
      inputs = {};
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs = {
        systems.follows = "systems";
      };
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs = {
        nixpkgs-lib.follows = "nixpkgs";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs = {};
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        # flake-parts modules (optional)
      ];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        formatter = pkgs.nixfmt;

        devShells.default = pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = with pkgs; [
            agenix.packages.${system}.default
          ];
        };

        checks = {
          pre-commit-check =
            inputs.pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                deadnix = {
                  enable = true;
                  settings.noLambdaArg = true;
                };
                nixfmt.enable = true;
                statix.enable = true;
              };
            };
        };
      };

      flake =
        let
          mkLib = pkgs:
            pkgs.lib.extend (_final: _prev:
              (import ./lib pkgs.lib pkgs)
              // inputs.home-manager.lib
            );

          mkSystem = {
            system ? "x86_64-linux",
            systemConfig,
            userConfigs,
            username ? "grovesauce",
            lib ? mkLib inputs.nixpkgs.legacyPackages.${system},
          }:
            inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
                outputs = self;
                inherit lib username;
              };

              modules = [
                { nixpkgs.hostPlatform = system; }

                systemConfig

                inputs.home-manager.nixosModules.home-manager
                inputs.impermanence.nixosModules.impermanence
                inputs.agenix.nixosModules.default

                ./modules/nixos
                inputs.stylix.nixosModules.stylix

                {
                  home-manager = {
                    sharedModules = [
                      ./modules/home
                      inputs.nixcord.homeModules.nixcord
                      inputs.plasma-manager.homeModules.plasma-manager
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
                      imports = [ userConfigs ];
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
}
