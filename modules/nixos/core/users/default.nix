{
  config,
  pkgs,
  ...
}:

{
  environment = {
    shells = [pkgs.fish];
    pathsToLink = ["/share/fish"];
  };

  programs = {
    less.enable = true;
    fish.enable = true;
  };

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

  users.groups.grovesauce = { };
}
