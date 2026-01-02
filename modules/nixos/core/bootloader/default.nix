{
  lib,
  ...
}:

{
  boot = {
    kernel = {
      sysctl."net.isoc" = true;
    };
    
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 15;
        editor = false;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };
}
