{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) getExe;

  workspaces = builtins.concatLists (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
      in
      [
        "SUPER, ${ws}, workspace, ${toString (x + 1)}"
        "SUPERSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    ) 10
  );

  zellij-attach = pkgs.writeShellScriptBin "zellij-attach" ''
    #! /bin/sh
    session=$(zellij ls -sn | rofi -dmenu -theme ~/.config/rofi/config.rasi -p "zellij session:")
    if [[ -z $session ]]; then
      exit
    fi
    ${terminal} -e zellij attach --create $session
  '';

  terminal = config.home.sessionVariables.TERMINAL;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      bind =
        let
          monocle = "dwindle:no_gaps_when_only";
        in
        [
          "CTRLSHIFT, Q, exit"
          "SUPER, Q, killactive"
          "SUPER, S, togglesplit"
          "SUPER, F, fullscreen"
          "SUPER, P, pseudo"
          "SUPERSHIFT, P, pin"
          "SUPER, space, togglefloating"
          "SUPER, Enter, exec, run-as-service foot"
          "SUPER, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"
          "SUPER, G, togglegroup"
          "SUPER, TAB, changegroupactive, f"
          "SUPERSHIFT, TAB, changegroupactive, b"
          "ALT, Tab, cyclenext"
          "ALT, Tab, bringactivetotop"
          "ALTSHIFT, Tab, cyclenext, prev"
          "ALTSHIFT, Tab, bringactivetotop"
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          "SUPERSHIFT, left, movewindow, l"
          "SUPERSHIFT, right, movewindow, r"
          "SUPERSHIFT, up, movewindow, u"
          "SUPERSHIFT, down, movewindow, d"
          "SUPERSHIFT, grave, movetoworkspace, special"
          "SUPER, grave, togglespecialworkspace"
          "SUPERALT, up, workspace, m-1"
          "SUPERALT, down, workspace, m+1"
          "SUPER, Return, exec, run-as-service ${terminal}"
          "SUPERSHIFT, Z, exec, ${getExe zellij-attach}"
          "SUPER, O, exec, run-as-service wl-ocr"
        ]
        ++ workspaces;

      bindr = [
        "SUPER, D, exec, vicinae open"
        "SUPERSHIFT, o, exec, wezterm start --class clipse clipse"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i 5"
        ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d 5"
        ", XF86MonBrightnessUp, exec, ${pkgs.brillo}/bin/brillo -q -A 10"
        ", XF86MonBrightnessDown, exec, ${pkgs.brillo}/bin/brillo -q -U 10"
        ",XF86AudioMute, exec, volumectl toggle-mute"
        ",XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset
    '';
  };
}
