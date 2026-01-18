{
  lib,
  config,
  ...
}:

{
  options = {
    funkouna = {
      services = {
        kanata = {
          enable = lib.mkEnableOption "kanata";
        };
      };
    };
  };

  config = {
    services = {
      kanata = lib.mkIf config.funkouna.services.kanata.enable {
        enable = true;
        keyboards = {
          internalKeyboard = {
            extraDefCfg = "process-unmapped-keys yes";
            config = ''
              (defsrc caps)
              (defvar tap-time 1 hold-time 1)
              (defalias caps (tap-hold 1 1 esc lctl))
              (deflayer base @caps)
            '';
          };
        };
      };
    };
  };
}
