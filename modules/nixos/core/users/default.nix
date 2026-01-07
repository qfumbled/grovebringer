{
  config,
  pkgs,
  ...
}:

{
  users.users.grovesauce = {
    isNormalUser = true;
    group = "grovesauce";
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
  users.groups.grovesauce = { };
}
