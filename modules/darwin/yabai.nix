# ref: https://github.com/crissNb/dotfiles/blob/main/yabai/yabairc
{
  services.yabai = {
    # SIP Must be disabled
    # enableScriptingAddition = true;
    config = {
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      window_origin_display = "focused";
      window_placement = "second_child";
      window_zoom_persist = "off";
      window_shadow = "on";
      window_animation_duration = 0.0;
      window_animation_frame_rate = 120;
      window_opacity_duration = 0.0;
      active_window_opacity = 1.0;
      normal_window_opacity = 0.9;
      window_opacity = "off";
      insert_feedback_color = "0xffd75f5f";
      split_ratio = 0.5;
      split_type = "auto";
      auto_balance = "off";
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      window_gap = 6;
      layout = "bsp";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig = ''
      yabai -m rule --add app="^Finder$" layer=above manage=off
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^System Information$" manage=off
      yabai -m rule --add app="^App Store$" manage=off
      yabai -m rule --add app="^Activity Monitor$" manage=off
      yabai -m rule --add app="^Messages$" manage=off

      yabai -m rule --add title="Preferences" manage=off
      yabai -m rule --add app="^1Password$" layer=above manage=off
      yabai -m rule --add app="^zoom.us$" manage=off
      yabai -m rule --add app="^coconutBattery$" manage=off
      yabai -m rule --add app="^Flux$" manage=off
      yabai -m rule --add app="^Ivanti Secure Access Client$" manage=off
      yabai -m rule --add app="^VLC$" manage=off
      yabai -m rule --add app="^CleanMyMac X$" manage=off
    '';
  };
}
