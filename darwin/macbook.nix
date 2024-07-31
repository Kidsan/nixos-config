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
    config = {
      external_bar = "off:40:0";
      menubar_opacity = "1.0";
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
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
      window_gap = "0";
      layout = "bsp";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
  };

}

