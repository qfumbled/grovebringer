{
  pkgs,
  username,
  ...
}:

{
  users = {
    groups = {
      "${username}" = {};
    };

    users = {
      "${username}" = {
        isNormalUser = true;
        group = username;
        extraGroups = [
          "wheel"
          "networkmanager"
          "video"
          "audio"
          "uinput"
          "adbusers"
          "plugdev"
        ];
        shell = pkgs.zsh;
      };
    };
  };

  programs = {
    zsh = {
      enable = true;
    };
  };
}
