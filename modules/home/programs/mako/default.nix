{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.funkouna.programs.mako.enable;
in
{
  options.funkouna.programs.mako = {
    enable = lib.mkEnableOption "Enable mako notification daemon";
  };

  config = lib.mkIf cfg {
    services.mako = with config.lib.stylix.colors.withHashtag; {
      enable = true;
      settings = lib.mkForce {
        sort = "-time";
        layer = "overlay";
        background-color = base00;
        text-color = base05;
        border-color = base0D;
        width = 200;
        height = 300;
        padding = "12";
        border-size = 2;
        border-radius = 0;
        markup = true;
        icons = true;
        format = ''%s\n\n%b'';
        actions = true;
        max-icon-size = 32;
        default-timeout = 0;
        ignore-timeout = true;
        font = "Rubik 9";

        "urgency=low" = {
          border-color = "${base0B}";
        };
        "urgency=normal" = {
          border-color = "${base01}";
        };
        "urgency=high" = {
          border-color = "${base08}";
        };
        "actionable" = {
          format = ''%s\n\n%b\n\nM-O to view actions'';
        };
      };
    };
  };
}
