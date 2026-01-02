{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.persistence."/persistent" = {
    directories = [
      "/etc/ssh"
      "/var/lib"
      "/var/log"
      "/home/xekuri/.cache"
      "/home/xekuri/.local"
      "/home/xekuri/.config"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
    users.xekuri = {
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
}
