{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./nixvim.nix
  ] ++ lib.funkouna.readSubdirs ./.;

  home = {
    username = config.lib.username or "grovesauce";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "25.11";
  };

  programs = {
    home-manager.enable = true;
  };

  home = {
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "foot";
    };
  };

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
}
