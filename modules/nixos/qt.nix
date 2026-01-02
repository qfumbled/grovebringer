{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  qt = {
    enable = true;
    platformTheme = "gtk2";  # Force using GTK2 theme
    style = {
      name = "gtk2";
      package = config.qt.style.package;
    };
  };
}
