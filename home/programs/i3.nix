{ ... }:
{
  # i3 config
  home.file = {
    "./.config/i3/config".text = /*i3config*/ ''
      set $mod Mod1
      default_border pixel 3
      for_window [class="^steam$"] border pixel 3
      for_window [class="^steam$" title="^Friends List$"] floating enable
      assign [class="(?i)steam_app_594650"] 9

      # exec "xautolock -detectsleep -time 3 -locker \"i3lock -c 000000\""

      # Font for window titles. Will also be used by the bar unless a different font
      # is used in the bar {} block below.
      font pango:monospace 8
      # default_border pixel 2

      # This font is widely installed, provides lots of unicode glyphs, right-to-left
      # text rendering and scalability on retina/hidpi displays (thanks to pango).
      #font pango:DejaVu Sans Mono 8

      # Start XDG autostart .desktop files using dex. See also
      # https://wiki.archlinux.org/index.php/XDG_Autostart
      exec --no-startup-id dex --autostart --environment i3

      # The combination of xss-lock, nm-applet and pactl is a popular choice, so
      # they are included here as an example. Modify as you see fit.

      # xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
      # screen before suspend. Use loginctl lock-session to lock your screen.
      # exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
      exec --no-startup-id xss-lock --transfer-sleep-lock --ignore-sleep -- i3lock --nofork

      # NetworkManager is the most popular way to manage wireless networks on Linux,
      # and nm-applet is a desktop environment-independent system tray GUI for it.
      exec --no-startup-id nm-applet

      # Use pactl to adjust volume in PulseAudio.
      set $refresh_i3status killall -SIGUSR1 i3status
      bindsym XF86AudioRaiseVolume exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0 && pkill -SIGRTMIN+10 i3blocks
      bindsym XF86AudioLowerVolume exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0 && pkill -SIGRTMIN+10 i3blocks
      bindsym XF86AudioMute exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && pkill -SIGRTMIN+10 i3blocks

      # Use Mouse+$mod to drag floating windows to their wanted position
      floating_modifier $mod

      # move tiling windows via drag & drop by left-clicking into the title bar,
      # or left-clicking anywhere into the window while holding the floating modifier.
      tiling_drag modifier titlebar

      # start a terminal
      bindsym $mod+Return exec alacritty

      # kill focused window
      bindsym $mod+Shift+Q kill

      # start dmenu (a program launcher)
      bindsym $mod+d exec --no-startup-id SHELL=/bin/sh dmenu_run
      # A more modern dmenu replacement is rofi:
      # bindcode $mod+40 exec "rofi -modi drun,run -show drun"
      # There also is i3-dmenu-desktop which only displays applications shipping a
      # .desktop file. It is a wrapper around dmenu, so you need that installed.
      # bindcode $mod+40 exec --no-startup-id i3-dmenu-desktop

      # change focus
      bindsym $mod+h focus left
      bindsym $mod+j focus down
      bindsym $mod+k focus up
      bindsym $mod+l focus right

      # alternatively, you can use the cursor keys:
      bindsym $mod+Left focus left
      bindsym $mod+Down focus down
      bindsym $mod+Up focus up
      bindsym $mod+Right focus right

      # move focused window
      bindsym $mod+Shift+H move left
      bindsym $mod+Shift+J move down
      bindsym $mod+Shift+K move up
      bindsym $mod+Shift+L move right

      # alternatively, you can use the cursor keys:
      bindsym $mod+Shift+Left move left
      bindsym $mod+Shift+Down move down
      bindsym $mod+Shift+Up move up
      bindsym $mod+Shift+Right move right

      # split in horizontal orientation
      bindsym $mod+b split h

      # split in vertical orientation
      bindsym $mod+v split v

      # enter fullscreen mode for the focused container
      bindsym $mod+f fullscreen toggle

      # change container layout (stacked, tabbed, toggle split)
      bindsym $mod+s layout stacking
      bindsym $mod+w layout tabbed
      bindsym $mod+e layout toggle split

      # toggle tiling / floating
      bindsym $mod+Shift+space floating toggle

      # change focus between tiling / floating windows
      bindsym $mod+space focus mode_toggle

      # focus the parent container
      bindsym $mod+a focus parent

      # focus the child container
      #bindsym $mod+d focus child

      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.
      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "10"

      # switch to workspace
      bindsym $mod+1 workspace number $ws1
      bindsym $mod+2 workspace number $ws2
      bindsym $mod+3 workspace number $ws3
      bindsym $mod+4 workspace number $ws4
      bindsym $mod+5 workspace number $ws5
      bindsym $mod+6 workspace number $ws6
      bindsym $mod+7 workspace number $ws7
      bindsym $mod+8 workspace number $ws8
      bindsym $mod+9 workspace number $ws9
      bindsym $mod+0 workspace number $ws10

      # move focused container to workspace
      bindsym $mod+Shift+exclam move container to workspace number $ws1
      bindsym $mod+Shift+quotedbl move container to workspace number $ws2
      bindsym $mod+Shift+sterling move container to workspace number $ws3
      bindsym $mod+Shift+dollar move container to workspace number $ws4
      bindsym $mod+Shift+percent move container to workspace number $ws5
      bindsym $mod+Shift+asciicircum move container to workspace number $ws6
      bindsym $mod+Shift+ampersand move container to workspace number $ws7
      bindsym $mod+Shift+asterisk move container to workspace number $ws8
      bindsym $mod+Shift+parenleft move container to workspace number $ws9
      bindsym $mod+Shift+parenright move container to workspace number $ws10

      # reload the configuration file
      bindsym $mod+Shift+C reload
      # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
      bindsym $mod+Shift+R restart
      # exit i3 (logs you out of your X session)
      bindsym $mod+Shift+E exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

      # resize window (you can also use the mouse for that)
      mode "resize" {
              # These bindings trigger as soon as you enter the resize mode

              # Pressing left will shrink the window’s width.
              # Pressing right will grow the window’s width.
              # Pressing up will shrink the window’s height.
              # Pressing down will grow the window’s height.
              bindsym j resize shrink width 10 px or 10 ppt
              bindsym k resize grow height 10 px or 10 ppt
              bindsym l resize shrink height 10 px or 10 ppt
              bindsym semicolon resize grow width 10 px or 10 ppt

              # same bindings, but for the arrow keys
              bindsym Left resize shrink width 10 px or 10 ppt
              bindsym Down resize grow height 10 px or 10 ppt
              bindsym Up resize shrink height 10 px or 10 ppt
              bindsym Right resize grow width 10 px or 10 ppt

              # back to normal: Enter or Escape or $mod+r
              bindsym Return mode "default"
              bindsym Escape mode "default"
              bindsym $mod+r mode "default"
      }

      bindsym $mod+r mode "resize"

      # gaming mode so that modifier key works in game
      mode "gaming" {
          bindsym $mod+Shift+G exec "~/.config/i3/mode_default.sh"
          bindsym $mod+f fullscreen toggle
          bindsym XF86AudioRaiseVolume exec --no-startup-id "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0 && pkill -SIGRTMIN+10 i3blocks"
          bindsym XF86AudioLowerVolume exec --no-startup-id "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0 && pkill -SIGRTMIN+10 i3blocks"
          bindsym XF86AudioMute exec --no-startup-id "kill -s USR1 $(ps -C gpu-screen-recorder)"
      }

      bindsym $mod+Shift+G exec "~/.config/i3/mode_gaming.sh"

      # exec_always --no-startup-id ~/.config/i3/bar.sh

      # Start i3bar to display a workspace bar (plus the system information i3status
      # finds out, if available)
      bar {
              status_command i3blocks
              position top
      }
    '';

    "./.config/i3blocks/config".text = ''
      # Global properties
      #
      # The top properties below are applied to every block, but can be overridden.
      # Each block command defaults to the script name to avoid boilerplate.
      # Change $SCRIPT_DIR to the location of your scripts!
      command=$SCRIPT_DIR/$BLOCK_NAME
      separator_block_width=15
      markup=none

      [CPU-temperature]
      label=
      command=/home/kidsan/.config/i3blocks/temperature/temperature --chip k10temp-pci-00c3
      color=#96c6f8
      interval=1

      # Volume indicator
      #
      # The first parameter sets the step (and units to display)
      # The second parameter overrides the mixer selection
      # See the script for details.

      [volume]
      label=♪ 
      # label=VOL
      interval=1
      signal=10
      command=wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -c 9-
      #STEP=5%

      [weather]
      command=curl -Ss 'https://wttr.in?0&T&Q' | cut -c 16- | head -2 | xargs echo
      interval=3600
      color=#A4C2F4

      # Date Time
      #
      [time]
      command=date '+%Y-%m-%d %H:%M:%S'
      interval=5
    '';

    "./.config/i3/mode_gaming.sh" = {
      executable = true;
      text = ''
        #!/bin/sh

        i3-msg 'mode gaming'
        setxkbmap -option -option caps:none

        window=$(xdotool getactivewindow)
        window_name=$(xdotool getwindowclassname "$window" || xdotool getwindowname "$window" || echo "game")
        gpu-screen-recorder -w "$window" -f 60 -c mp4 -a "alsa_output.usb-Universal_Audio_Volt_1_23032036038581-00.analog-stereo.monitor" -r 30 -o "$HOME/Videos/replay/$window_name"
      '';
    };

    "./.config/i3/mode_default.sh" = {
      executable = true;
      text = ''
        #!/bin/sh
        i3-msg 'mode default'
        setxkbmap -option -option caps:escape
        pkill gpu-screen-reco
      '';
    };

  };
}
