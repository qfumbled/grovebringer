{
  config,
  pkgs,
  ...
}:

{
  users.users.xekuri = {
    isNormalUser = true;
    group = "xekuri";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "uinput"
      "adbusers"
      "plugdev"
    ];
  };

  users.groups.xekuri = {};
}
