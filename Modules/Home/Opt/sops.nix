{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  config = {
    sops = {
      defaultSopsFile = "${inputs.self}/secrets/xekuri/secrets.yaml";
      defaultSopsFormat = "yaml";

      age = {
        generateKey = true;
        keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
        sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      };
    };
  };
}
