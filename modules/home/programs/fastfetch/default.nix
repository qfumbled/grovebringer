{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs = {
    fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

        logo = {
          type = "file";
          source = ./NixOS-alt.txt;
        };

        display = {
          separator = ": ";
          color = {
            keys = "cyan";
            title = "blue";
          };
          key = {
            width = 15;
          };
          showErrors = true;
        };

        modules = [
          "title"
          "separator"
          {
            type = "os";
            key = "OS";
          }
          {
            type = "host";
            key = "Host";
          }
          {
            type = "kernel";
            key = "Kernel";
          }
          {
            type = "packages";
            key = "Packages";
          }
          {
            type = "shell";
            key = "Shell";
          }
          {
            type = "display";
            key = "Display";
          }
          {
            type = "wm";
            key = "WM";
          }
          {
            type = "theme";
            key = "Theme";
          }
          {
            type = "icons";
            key = "Icons";
          }
          {
            type = "font";
            key = "Font";
          }
          {
            type = "cursor";
            key = "Cursor";
          }
          {
            type = "terminal";
            key = "Terminal";
          }
          {
            type = "terminalfont";
            key = "Terminal Font";
          }
          {
            type = "media";
            key = "Media";
          }
          {
            type = "cpu";
            key = "CPU";
          }
          {
            type = "gpu";
            key = "GPU";
          }
          {
            type = "memory";
            key = "Memory";
          }
          {
            type = "disk";
            key = "Disk";
          }
          {
            type = "battery";
            key = "Battery";
            percent = {
              green = 50;
              yellow = 20;
            };
          }
          {
            type = "locale";
            key = "Locale";
          }
        ];
      };
    };
  };
}