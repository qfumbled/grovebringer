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
