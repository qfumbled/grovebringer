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
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  users.groups.xekuri = {};
}
