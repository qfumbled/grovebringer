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
        anchor = "top-right";
        output = "";
        margin = "25,25,0,25";
        padding = "25";
        width = 350;
        height = 150;
        
        # Colors and styling
        background-color = base00 + "e6";  # Slight transparency
        text-color = base05;
        border-color = base0D;
        border-size = 2;
        border-radius = 0;  # Sharp corners
        
        # Text and formatting
        font = "Rubik 12";
        markup = true;
        format = ''%s %b'';  # Single space between summary and body
        text-alignment = "left";
        
        icons = true;
        max-icon-size = 48;
        icon-location = "left";
        
        actions = true;
        default-timeout = 5000;
        ignore-timeout = false;
        group-by = "app-name,summary";
        
        max-visible = 5;
        
        "urgency=low" = {
          border-color = "${base0B}";
          background-color = base00 + "e6";
          default-timeout = 3000;
        };
        
        "urgency=normal" = {
          border-color = "${base0D}";
          background-color = base00 + "e6";
          default-timeout = 5000;
        };
        
        "urgency=high" = {
          border-color = "${base08}";
          background-color = base00 + "e6";
          border-size = 3;
          default-timeout = 0;
        };
        
        # Actionable notifications
        "actionable" = {
          format = ''<b>%a</b>\n%s\n\n%b\n\n<span size="smaller" color="${base04}">Press M-O for actions</span>'';
        };
        
        # Grouping
        "grouped" = {
          margin = "10";
          format = ''<b>%a</b>\n%s\n\n<span size="smaller" color="${base04}">%g more from %a</span>'';
        };
      };
    };
  };
}
