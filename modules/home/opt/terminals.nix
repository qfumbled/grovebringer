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

  config = lib.mkIf config.funkouna.home.terminals.enable {
    # Terminal configurations here
  };
}
