{
  lib,
  username,
  config,
  ...
}:
{
  imports = lib.funkouna.readSubdirs ./.;
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
    sessionVariables = {
      EDITOR = "zed";
      TERMINAL = "foot";
      BROWSER = "zen";
    };
  };
}
