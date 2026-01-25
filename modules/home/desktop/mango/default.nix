{
  pkgs,
  lib,
  ...
}:
{
  wayland = {
    windowManager = {
      mango = {
        enable = true;

        settings = ''
          # Appearance - Solarized Light from dwl
          rootcolor = 0x93a1a1ff
          borderpx = 3
          border_radius = 0

          # Colors: SchemeNorm/SchemeSel from dwl config.h
          bordercolor = 0xeee8d5ff
          focuscolor = 0xc0c4bbff
          urgentcolor = 0x770000ff

          focused_opacity = 1.0
          unfocused_opacity = 1.0

          # Gaps - dwl gappx = 8
          gappih = 8
          gappiv = 8
          gappoh = 8
          gappov = 8
          smartgaps = 0

          # Layout - dwl defaults
          new_is_master = 1
          default_mfact = 0.5
          default_nmaster = 1

          # Focus behavior
          sloppyfocus = 0

          # Overview
          enable_hotarea = 0
          hotarea_size = 10
          overviewgappi = 5
          overviewgappo = 30

          # No animations (dwl has none)
          animations = 0
          layer_animations = 0

          # Keyboard - dwl defaults
          repeat_rate = 25
          repeat_delay = 600

          # Trackpad - from dwl config.h
          tap_to_click = 1
          tap_and_drag = 1
          drag_lock = 1
          trackpad_natural_scrolling = 0
          disable_while_typing = 1
          left_handed = 0
          middle_button_emulation = 0
          scroll_method = 1
          click_method = 1
          send_events_mode = 0
          accel_profile = 2
          accel_speed = 0.0

          # Window rules - dwl: wezterm is terminal for swallowing
          windowrule = appid:wezterm,isterm:1

          # Keybindings - matching dwl exactly
          bind = SUPER,d,spawn,wmenu-run
          bind = SUPER,Return,spawn,wezterm
          bind = NONE,Print,spawn,slurp | grim -g -
          bind = SUPER,b,togglebar
          bind = SUPER,j,focusstack,next
          bind = SUPER,k,focusstack,prev
          bind = SUPER,i,incnmaster
          bind = SUPER,o,incnmaster,-1
          bind = SUPER,h,setmfact,-5
          bind = SUPER,l,setmfact,+5
          bind = SUPER,z,zoom
          bind = SUPER,Tab,view,-1
          bind = SUPER,q,killclient
          bind = SUPER,space,switch_layout
          bind = SUPER+SHIFT,space,togglefloating
          bind = SUPER,f,togglefullscreen
          bind = SUPER,0,view,0
          bind = SUPER+SHIFT,0,tag,0
          bind = SUPER,comma,focusmon,left
          bind = SUPER,period,focusmon,right
          bind = SUPER+SHIFT,comma,tagmon,left,0
          bind = SUPER+SHIFT,period,tagmon,right,0

          bind = NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0
          bind = NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05- -l 1.0
          bind = NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          bind = NONE,XF86MonBrightnessUp,spawn,brightnessctl --class=backlight set +5%
          bind = NONE,XF86MonBrightnessDown,spawn,brightnessctl --class=backlight set 5%-

          # Tag keys (1-5 as in dwl, Mango supports up to 9)
          bind = SUPER,1,view,1
          bind = SUPER+CTRL,1,toggleview,1
          bind = SUPER+SHIFT,1,tag,1
          bind = SUPER+CTRL+SHIFT,1,toggletag,1

          bind = SUPER,2,view,2
          bind = SUPER+CTRL,2,toggleview,2
          bind = SUPER+SHIFT,2,tag,2
          bind = SUPER+CTRL+SHIFT,2,toggletag,2

          bind = SUPER,3,view,3
          bind = SUPER+CTRL,3,toggleview,3
          bind = SUPER+SHIFT,3,tag,3
          bind = SUPER+CTRL+SHIFT,3,toggletag,3

          bind = SUPER,4,view,4
          bind = SUPER+CTRL,4,toggleview,4
          bind = SUPER+SHIFT,4,tag,4
          bind = SUPER+CTRL+SHIFT,4,toggletag,4

          bind = SUPER,5,view,5
          bind = SUPER+CTRL,5,toggleview,5
          bind = SUPER+SHIFT,5,tag,5
          bind = SUPER+CTRL+SHIFT,5,toggletag,5

          # Mouse bindings - matching dwl
          mousebind = SUPER,btn_left,moveresize,curmove
          mousebind = SUPER,btn_right,moveresize,curresize
          mousebind = NONE,btn_middle,togglemaximizescreen,0
        '';

        autostart_sh = ''
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
        '';
      };
    };
  };
}
