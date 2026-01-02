{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./foot
  ];

  config = lib.mkIf config.grovebringer.home.terminals.enable {
    # Terminal configurations here
  };
}
