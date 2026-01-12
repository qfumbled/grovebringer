{
  lib,
  config,
  pkgs,
  ...
}:

{
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true; 
  };
}
