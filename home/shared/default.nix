{
  lib,
  pkgs,
  ...
}:

{
  # Shared home-manager configuration
  # This file contains common settings shared across all profiles
  
  home = {
    # Basic home-manager settings
    stateVersion = "25.11";
  };

  # Shared packages that all profiles should have
  home.packages = with pkgs; [
    # Basic utilities
    coreutils
    findutils
    gnugrep
    gnused
    gnutar
    gzip
  ];

  # Shared environment variables
  home.sessionVariables = {
    EDITOR = "nano";
    BROWSER = "firefox";
  };
}
