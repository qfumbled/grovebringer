{
  description = " complex flake by fumbled ";

  outputs =
    inputs @ {
      self,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        # ...
      ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          formatter = pkgs.nixfmt;

          devShells = {
            default = pkgs.mkShell {
              inherit (self.checks.${system}.pre-commit-check) shellHook;
            };
          };

          checks = {
            pre-commit-check =
              inputs.pre-commit-hooks.lib.${system}.run {
                src = ./.;

                hooks = {
                  deadnix = {
                    enable = true;
                    settings = {
                      noLambdaArg = true;
                    };
                  };

                  nixfmt = {
                    enable = true;
                  };

                  statix = {
                    enable = true;
                  };
                };
              };
          };
        };

      flake =
        let
          mkLib =
            pkgs:
            pkgs.lib.extend
              (
                _final:
                _prev:
                (import ./lib pkgs.lib pkgs)
                // inputs.home-manager.lib
              );

          mkSystem =
            {
              system ? "x86_64-linux",
              systemConfig,
              userConfigs,
              username ? "grovesauce",
              lib ? mkLib inputs.nixpkgs.legacyPackages.${system},
            }:
            inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs lib username;
                outputs = self;
              };

              modules = [
                {
                  nixpkgs = {
                    hostPlatform = system;
                  };
                }

                systemConfig
                inputs.nix-flatpak.nixosModules.nix-flatpak
                inputs.home-manager.nixosModules.home-manager
                inputs.impermanence.nixosModules.impermanence
                inputs.stylix.nixosModules.stylix

                ./modules/nixos

                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;

                    sharedModules = [
                      ./modules/home
                      inputs.noctalia.homeModules.default
                      inputs.zen-browser.homeModules.beta
                      inputs.nixcord.homeModules.nixcord
                      inputs.plasma-manager.homeModules.plasma-manager
                    ];

                    extraSpecialArgs = {
                      inherit inputs lib username;
                      outputs = self;
                    };

                    users = {
                      ${username} = {
                        home = {
                          stateVersion = "25.11";
                        };

                        imports = [
                          userConfigs
                        ];
                      };
                    };
                  };
                }
              ];
            };
        in
        {
          nixosConfigurations = {
            jemflake = mkSystem {
              systemConfig = ./hosts/jemflake;
              userConfigs = ./home/profiles/jemflake.nix;
            };

            aureliteiron = mkSystem {
              systemConfig = ./hosts/aureliteiron;
              userConfigs = ./home/profiles/aureliteiron.nix;
            };
          };
        };
    };

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      inputs = {
        # ...
      };
    };

    systems = {
      url = "github:nix-systems/default-linux";
      inputs = {
        # ...
      };
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
      inputs = {
        # ...
      };
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

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
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

    sops-nix = {
      url = "github:Mic92/sops-nix";
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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/";
      inputs = {
        # ...
      };
    };
  };
}
