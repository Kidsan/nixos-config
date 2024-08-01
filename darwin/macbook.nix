{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.vim
  ];

  environment.shells = [ pkgs.nushell ];
  users.users.kieranosullivan.shell = pkgs.nushell;
  environment.loginShell = pkgs.nushell;

  documentation.enable = false;
  documentation.doc.enable = false;
  documentation.info.enable = false;
  documentation.man.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixVersions.latest;
  programs.zsh.enable = true;
  programs.zsh.promptInit = "";
  nix.settings.trusted-users = [ "root" "kieranosullivan" ];
  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    experimental-features = nix-command flakes
  '';

  # fonts.fontDir.enable = true;
  fonts.packages = [
    pkgs.jetbrains-mono
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    extraConfig = ''
      function setup_space {
        local idx="$1"
        local space=
        echo "setup space $idx "

        space=$(yabai -m query --spaces --space "$idx")
        if [ -z "$space" ]; then
          yabai -m space --create
        fi
      }

      setup_space 1
      setup_space 2
      setup_space 3
      setup_space 4
      setup_space 5
      setup_space 6
      setup_space 7
      setup_space 8
      setup_space 9
    '';
    config = {
      external_bar = "off:40:0";
      menubar_opacity = "1.0";
      mouse_follows_focus = "off";
      focus_follows_mouse = "on";
      display_arrangement_order = "default";
      window_origin_display = "default";
      window_placement = "second_child";
      window_zoom_persist = "on";
      window_shadow = "on";
      window_animation_duration = "0.0";
      window_animation_easing = "ease_out_circ";
      window_opacity_duration = "0.0";
      active_window_opacity = "1.0";
      normal_window_opacity = "0.90";
      window_opacity = "off";
      insert_feedback_color = "0xffd75f5f";
      split_ratio = "0.50";
      split_type = "auto";
      auto_balance = "off";
      top_padding = "0";
      bottom_padding = "0";
      left_padding = "0";
      right_padding = "0";
      window_gap = "1";
      layout = "bsp";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
  };


  services.skhd = {
    enable = true;
    skhdConfig = ''
      # move window
      lshift + cmd - h : yabai -m window --swap east
      lshift + cmd - l : yabai -m window --swap west
      lshift + cmd - k : yabai -m window --swap north
      lshift + cmd - j : yabai -m window --swap south
      lshift + cmd - 1 : yabai -m window --space 1
      lshift + cmd - 2 : yabai -m window --space 2
      lshift + cmd - 3 : yabai -m window --space 3
      lshift + cmd - 4 : yabai -m window --space 4
      lshift + cmd - 5 : yabai -m window --space 5
      lshift + cmd - 6 : yabai -m window --space 6
      lshift + cmd - 7 : yabai -m window --space 7
      lshift + cmd - 8 : yabai -m window --space 8
      lshift + cmd - 9 : yabai -m window --space 9

      # focus window
      cmd - h : yabai -m window --focus west
      cmd - l : yabai -m window --focus east
      cmd - j : yabai -m window --focus south
      cmd - k : yabai -m window --focus north


      # move workspaces
      cmd - 1 : yabai -m space --focus 1
      cmd - 2 : yabai -m space --focus 2
      cmd - 3 : yabai -m space --focus 3
      cmd - 4 : yabai -m space --focus 4
      cmd - 5 : yabai -m space --focus 5
      cmd - 6 : yabai -m space --focus 6
      cmd - 7 : yabai -m space --focus 7
      cmd - 8 : yabai -m space --focus 8
      cmd - 9 : yabai -m space --focus 9

      cmd - return : alacritty
    '';
  };

  services.sketchybar = {
    enable = true;
  };


}

