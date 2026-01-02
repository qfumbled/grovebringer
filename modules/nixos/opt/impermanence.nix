{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  options.grovebringer.nixos.impermanence = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable state persistence";
    };
  };

  config = lib.mkIf config.grovebringer.nixos.impermanence.enable {
    environment.persistence."/persistent" = lib.mkIf (builtins.pathExists "/persistent") {
      directories = [
        "/etc/ssh"
        "/var/lib"
        "/var/log"
        "/home/${username}/.cache"
        "/home/${username}/.local"
        "/home/${username}/.config"
      ];
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
      users.${username} = {
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
          "Music"
          ".gnupg"
          ".ssh"
          ".local/share/spotify"
        ];
        files = [
          ".bashrc"
          ".profile"
        ];
      };
    };
  };
}
