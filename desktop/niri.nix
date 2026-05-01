{ inputs, hostVars, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

  programs.niri.enable = true;

  hm = { config, ... }:
  {
    imports = [
      inputs.niri-flake.homeModules.niri
    ];
    
    programs.swaylock.enable = true;
    services.swayidle =
      let
        lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
        display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
      in
        {
          enable = true;
          timeouts = [
            { timeout = 15; command = lock; }
            { timeout = 25; command = display "off"; resumeCommand = display "on"; }
            { timeout = 30; command = "systemctl suspend"; }
          ];
          events = {
            "before-sleep" = (display "off") + ";" + lock;
            "after-resume" = display "on";
          };
        };
    services.polkit-gnome.enable = true;
    
    programs.niri = {
      enable = true;
      settings = {
        input = {
          keyboard = {
            numlock = true;
            xkb.options = "ctrl:swapcaps";
          };
          
          mouse = {
            accel-speed = -1.0;
          };
          
          touchpad = {
            dwt = true;
          };
        };
        
        outputs = {
          "eDP-1" = {
            mode = {
              width = hostVars.display.width;
              height = hostVars.display.height;
              refresh = hostVars.display.refresh;
            };

            variable-refresh-rate = true;            
          };
        };

        layout = {
          background-color = "transparent";
          gaps = 0;
          focus-ring.enable = false;

          border = {
            enable = true;
            width = 2;
          };
          
          shadow = {
            enable = true;
            softness = 10;
            spread = 5;
            offset = { x = 0; y = 5; };
          };

          default-column-width = { proportion = 1. / 2.; };
          preset-column-widths = [
            { proportion = 1. / 3.; }
            { proportion = 1. / 2.; }
            { proportion = 2. / 3.; }
          ];
        };

        layer-rules = [
          { matches = [ { namespace = "^wallpaper$"; } ]; place-within-backdrop = true; }
        ];

        hotkey-overlay.skip-at-startup = true;
        prefer-no-csd = true;
        gestures.hot-corners.enable = false;
        
        spawn-at-startup = [
        ];

        binds = with config.lib.niri.actions; {
          "Mod+Shift+Slash".action = show-hotkey-overlay;
          "Mod+Shift+E".action = quit;
          "Mod+O".action = toggle-overview;
          
          "Mod+S".action = maximize-column;
          "Mod+Shift+S".action = fullscreen-window;
          "Mod+R".action = switch-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Q".action = close-window;
          
          "Mod+P".action = focus-window-or-workspace-up;
          "Mod+B".action = focus-column-left;
          "Mod+F".action = focus-column-right;
          "Mod+N".action = focus-window-or-workspace-down;
          
          "Mod+Ctrl+P".action = move-window-up-or-to-workspace-up;
          "Mod+Ctrl+B".action = move-column-left;
          "Mod+Ctrl+F".action = move-column-right;
          "Mod+Ctrl+N".action = move-window-down-or-to-workspace-down;
          
          "Mod+Shift+P".action = focus-monitor-up;
          "Mod+Shift+B".action = focus-monitor-left;
          "Mod+Shift+F".action = focus-monitor-right;
          "Mod+Shift+N".action = focus-monitor-down;
          
          "Mod+Shift+Ctrl+P".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+B".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+F".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+N".action = move-column-to-monitor-down;

          "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "-l" "1.0" ];
          "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" "-l" "0.0" ];
          "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
          "XF86AudioMicMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];

          "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "s" "5%+" ];
          "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "s" "5%-" ];

          "Mod+E".action.spawn = "emacs";
          "Mod+Return".action.spawn = "alacritty";
        };
      };
    };
  };
}
