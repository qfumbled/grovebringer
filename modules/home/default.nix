{
  lib,
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
      EDITOR = "zed";
      BROWSER = "firefox";
      TERMINAL = "foot";
    };
  };
}
