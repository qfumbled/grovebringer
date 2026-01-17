{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.services.tpm;
in
{
  options.funkouna.services = {
    tpm.enable = mkEnableOption "TPM2 support";
  };

  config = mkIf cfg.enable {
    security.tpm2 = {
      enable = true;
      pkcs11.enable = true;         # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
      tctiEnvironment.enable = true; # sets TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
    };

    users = {
      users = {
        ${username} = {
          extraGroups = [
            "tss"  # tss group has access to TPM devices
          ];
        };
      };
    };
  };
}
