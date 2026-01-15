{
  lib,
  config,
  pkgs,
  inputs,
  username,
  ...
}:

{
  imports = lib.funkouna.readSubdirs ./.;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "foot";
    };
  };
}
