{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.system.nix;
in
{
  config = mkIf cfg.enable {
    nix = {
      settings = {
        substituters = [
          "https://cache.nixos.org"
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
          "https://cache.lix.systems"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        ];

        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];

        trusted-users = [
          "root"
          "@wheel"
        ];

        auto-optimise-store = true;
        warn-dirty = false;
      };

      channel.enable = false;

      gc = {
        automatic = true;
        options = "--delete-older-than 1d";
        dates = "22:30";
      };

      optimise.automatic = true;
    };

    nixpkgs.config = {
      permittedInsecurePackages = [
        "electron-27.3.11"
        "electron-30.5.1"
        "nix-2.24.5"
      ];

      allowUnfree = true;
      allowBroken = true;
      allowUnfreePredicate = _: true;
    };

    nixpkgs.overlays = [
      inputs.nur.overlays.default
    ];
  };
}
