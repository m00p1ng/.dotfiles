# ref: https://github.com/crissNb/dotfiles/blob/main/yabai/yabairc
{
  services.yabai = {
    enable = true;
    # SIP Must be disabled
    # enableScriptingAddition = true;
    config = {
      external_bar = "all:28:0";
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      window_origin_display = "default";
      window_placement = "second_child";
      window_zoom_persist = "off";
      window_shadow = "on";
      window_animation_duration = 0.0;
      window_animation_frame_rate = 120;
      window_opacity_duration = 0.0;
      active_window_opacity = 1.0;
      normal_window_opacity = 0.90;
      window_opacity = "off";
      insert_feedback_color = "0xffd75f5f";
      split_ratio = 0.50;
      split_type = "auto";
      auto_balance = "off";
      window_gap = 6;
      layout = "bsp";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig = ''
      yabai -m rule --add app="^Finder$" sticky=on layer=above manage=off
      yabai -m rule --add label="System Settings" app="^System Settings$" manage=off
      yabai -m rule --add label="App Store" app="^App Store$" manage=off
      yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      yabai -m rule --add app="^Messages$" layer=above manage=off
      yabai -m rule --add app="^1Password$" layer=above manage=off
    '';
  };
}
