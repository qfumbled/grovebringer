{
  lib,
  config,
  username,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.services.tpm;
in
{
  options = {
    funkouna = {
      services = {
        tpm = {
          enable = mkEnableOption "TPM2 support";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    security = {
      tpm2 = {
        enable = true;
        pkcs11 = {
          enable = true;
        };
        tctiEnvironment = {
          enable = true;
        };
      };
    };

    users = {
      users = {
        ${username} = {
          extraGroups = [
            "tss"
          ];
        };
      };
    };
  };
}
