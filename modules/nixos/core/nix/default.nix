{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nix = {
    settings = {
      substituters = lib.mkDefault [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://chaotic-nyx.cachix.org"
        "https://nix-gaming.cachix.org"
      ];

      
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  

      experimental-features = lib.mkDefault [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      trusted-users = lib.mkDefault [
        "root"
        "@wheel"
      ];

      auto-optimise-store = lib.mkDefault true;
      warn-dirty = lib.mkDefault false;
      max-jobs = lib.mkDefault "auto";
    };

    channel.enable = lib.mkDefault false;

    gc = lib.mkDefault {
      automatic = true;
      options = "--delete-older-than 30d";
      dates = "22:30";
    };

    optimise.automatic = lib.mkDefault true;
  };

  nixpkgs.config = {
    permittedInsecurePackages = [
      "electron-27.3.11"
      "electron-30.5.1"
      "nix-2.24.5"
      "qtwebengine-5.15.19"
    ];

    allowUnfree = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
  };

  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld;
  };
}