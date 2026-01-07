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
