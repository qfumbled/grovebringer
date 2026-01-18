{
  ...
}:

{
  system = {
    copySystemConfiguration = false;
    stateVersion = "25.11";
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
