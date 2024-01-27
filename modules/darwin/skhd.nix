{
  services.skhd = {
    skhdConfig = ''
      # focus window
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      # swap managed window
      alt + shift - h : yabai -m window --swap west
      alt + shift - j : yabai -m window --swap south
      alt + shift - k : yabai -m window --swap north
      alt + shift - l : yabai -m window --swap east

      # float mode yabai
      alt + shift - q : yabai -m config layout float
      # Bsp mode yabai
      alt - shift - w: yabai -m config layout bsp

      # Example for sckatchy bar config
      lalt - space : yabai -m window --toggle float; sketchybar --trigger window_focus
      shift + lalt - f : yabai -m window --toggle zoom-fullscreen; sketchybar --trigger window_focus
      lalt - f : yabai -m window --toggle zoom-parent; sketchybar --trigger window_focus
    '';
  };
}
