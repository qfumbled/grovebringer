{
  pkgs,
  inputs,
  ...
}:
{
  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
      "nix-2.24.5"
      "qtwebengine-5.15.19"
    ];

    allowUnfree = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
  };

  nixpkgs.overlays = [

  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld;
  };
}
