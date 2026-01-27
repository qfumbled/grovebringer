{
  pkgs,
  lib,
  ...
}:

{
  wayland.windowManager.mango = {
    enable = true;

    settings = ''
      # Appearance - Solarized Dark
      rootcolor = 0x073642ff
      borderpx = 3
      border_radius = 0
      bordercolor = 0x586e75ff
      focuscolor = 0x268bd2ff
      urgentcolor = 0xdc322fff

      focused_opacity = 1.0
      unfocused_opacity = 1.0

      # Bar / title
      showbar = 1
      topbar = 1
      centered_title = 1
      font = "0xProto 12"

      # Gaps
      gappih = 8
      gappiv = 8
      gappoh = 8
      gappov = 8
      smartgaps = 0
      gaps = 1

      # Layout
      new_is_master = 1
      default_mfact = 0.5
      default_nmaster = 1

      # Focus / animations
      sloppyfocus = 0
      enable_hotarea = 0
      hotarea_size = 10
      overviewgappi = 5
      overviewgappo = 30
      animations = 0
      layer_animations = 0

      # Keyboard repeat
      repeat_rate = 25
      repeat_delay = 600

      # Trackpad / input
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

      # Window rules
      windowrule = appid:wezterm,isterm:1

      # Keybindings
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

      # Volume and brightness keys
      bind = NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0
      bind = NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05- -l 1.0
      bind = NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = NONE,XF86MonBrightnessUp,spawn,brightnessctl --class=backlight set +5%
      bind = NONE,XF86MonBrightnessDown,spawn,brightnessctl --class=backlight set 5%-

      # Workspaces
      bind = SUPER,1,view,1
      bind = SUPER,2,view,2
      bind = SUPER,3,view,3
      bind = SUPER,4,view,4
      bind = SUPER,5,view,5

      # Mouse bindings
      mousebind = SUPER,btn_left,moveresize,curmove
      mousebind = SUPER,btn_right,moveresize,curresize
      mousebind = NONE,btn_middle,togglemaximizescreen,0
    '';

    autostart_sh = ''
      export XDG_CURRENT_DESKTOP=MangoWC

      # Start Noctalia Shell in background
      (sleep 1; noctalia-shell >/tmp/noctalia.log 2>&1 &) &
    '';
  };
}
