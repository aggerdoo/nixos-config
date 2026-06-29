{ config, lib, pkgs, inputs, ... }:

let
 inherit (inputs.niri.lib.kdl) node plain leaf flag;
in {

 imports = [
   inputs.niri.homeModules.niri
 ];
  
 programs.niri = {
   enable = true;
   package = pkgs.niri;
 };

 programs.niri.config = [
    (plain "input" [
      (plain "keyboard" [
        (plain "xkb" [
          (leaf "layout" "gb")
        ])
      ])

      (plain "mouse" [
        # (flag "natural-scroll")
        # (leaf "accel-speed" 0.2)
        # (leaf "accel-profile" "flat")
      ])
    ])

    
    (plain "xwayland-satellite" [
      (flag "on")
      (leaf "path" (lib.getExe pkgs.xwayland-satellite))
    ])
   
    (node "output" "DP-1" [
      (leaf "scale" 0.85)
      (leaf "transform" "normal")
      (leaf "mode" "1920x1080@165.003")
      (leaf "position" { x=1280; y=0; })
    ])

    (node "output" "DP-2" [
      (leaf "scale" 0.9)
      (leaf "transform" "normal")
      (leaf "mode" "2560x1440@180.02")
      (leaf "position" { x=0; y=0; })
    ])

    (node "output" "DP-3" [
      (leaf "scale" 0.85)
      (leaf "transform" "normal")
      (leaf "mode" "1920x1080@143.995")
      #(leaf "position" { x=1280; y=0; })
    ])

    (plain "layout" [
        (plain "focus-ring" [
        (leaf "width" 2)
        (leaf "active-color" "#7fc8ff")
        (leaf "inactive-color" "#505050")
      ])

      (plain "border" [
        (flag "off")
        (leaf "width" 4)
        (leaf "active-color" "#ffc87f")
        (leaf "inactive-color" "#505050")

        # (leaf "active-gradient" { from="#ffbb66"; to="#ffc880"; angle=45; relative-to="workspace-view"; })
        # (leaf "inactive-gradient" { from="#505050"; to="#808080"; angle=45; relative-to="workspace-view"; })
      ])

      (plain "preset-column-widths" [
        (leaf "proportion" (1.0 / 3.0))
        (leaf "proportion" (1.0 / 2.0))
        (leaf "proportion" (2.0 / 3.0))
      ])

      (plain "default-column-width" [
        (leaf "proportion" 0.5)
      ])

      (leaf "gaps" 6)

      (plain "struts" [
        # (leaf "left" 64)
        # (leaf "right" 64)
        # (leaf "top" 64)
        # (leaf "bottom" 64)
      ])

      (leaf "center-focused-column" "never")
    ])

    (leaf "spawn-at-startup" [ "elephant" ])
    (leaf "spawn-at-startup" [ "walker" "--gapplication-service" ])
    (leaf "spawn-at-startup" [ "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" ])
    (leaf "spawn-at-startup" [ "noctalia-shell" ])
    #(leaf "spawn-at-startup" [ "xwayland-satellite" ])

    (plain "environment" [
      (leaf "QT_QPA_PLATFORM" "wayland")
      (leaf "SDL_VIDEODRIVER" "wayland,x11")
      (leaf "GDK_BACKEND" "wayland")
      (leaf "NIXOS_OZONE_WL" "1")
      (leaf "MOZ_ENABLE_WAYLAND" "1")
      (leaf "LIBVA_DRIVER_NAME" "radeonsi")
      (leaf "QT_WAYLAND_DISABLE_WINDODECORATION" "1")
    ])

    (plain "cursor" [
      # Change the theme and size of the cursor as well as set the
      # `XCURSOR_THEME` and `XCURSOR_SIZE` env variables.
      # (leaf "xcursor-theme" "default")
      # (leaf "xcursor-size" 24)
    ])

    (flag "prefer-no-csd")

    (leaf "screenshot-path" "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png")


    (plain "hotkey-overlay" [
      # Uncomment this line if you don't want to see the hotkey help at niri startup.
      # (flag "skip-at-startup")
    ])

    (plain "animations" [
      # Uncomment to turn off all animations.
      # (flag "off")

      # (leaf "slowdown" 3.0)

      (plain "workspace-switch" [
        # (flag "off")
        # (leaf "spring" { damping-ratio=1.0; stiffness=1000; epsilon=0.0001; })
      ])

      (plain "horizontal-view-movement" [
        # (flag "off")
        # (leaf "spring" { damping-ratio=1.0; stiffness=800; epsilon=0.0001; })
      ])

      (plain "window-open" [
        # (flag "off")
        # (leaf "duration-ms" 150)
        # (leaf "curve" "ease-out-expo")

        # Example for a slightly bouncy window opening:
        # (leaf "spring" { damping-ratio=0.8; stiffness=1000; epsilon=0.0001; })
      ])

      # Config parse error and new default config creation notification
      # open/close animation.
      (plain "config-notification-open-close" [
        # (flag "off")
        # (leaf "spring" { damping-ratio=0.6; stiffness=1000; epsilon=0.001; })
      ])
    ])

    (plain "window-rule" [
      (leaf "match" { app-id=''r#"firefox$"r#''; title=''^Picture-in-Picture$''; })
      (leaf "open-floating" true)
    
      (leaf "match" { title="Second App"; })

      (leaf "exclude" { app-id=''\.unwanted\.''; })

      (plain "default-column-width" [
        (leaf "proportion" 0.75)
      ])

      #(leaf "open-on-output" "eDP-1")

      # Make this window open as a maximized column.
      (leaf "open-maximized" true)

      # Make this window open fullscreen.
      (leaf "open-fullscreen" true)
      # You can also set this to false to prevent a window from opening fullscreen.
      # (leaf "open-fullscreen" false)
    ])

    # Here's a useful example. Work around WezTerm's initial configure bug
    # by setting an empty default-column-width.
    (plain "window-rule" [
      # This regular expression is intentionally made as specific as possible,
      # since this is the default config, and we want no false positives.
      # You can get away with just app-id="wezterm" if you want.
      # The regular expression can match anywhere in the string.
      (leaf "match" { app-id=''^org\.wezfurlong\.wezterm$''; })
      (plain "default-column-width" [])
    ])

    (plain "binds" [
      (plain "Mod+Shift+Slash" [(flag "show-hotkey-overlay")])

      # Suggested binds for running programs: terminal, app launcher, screen locker.
      (plain "Mod+Return" [(leaf "spawn" ["ghostty"])])
      (plain "Mod+W" [(leaf "spawn" ["firefox"])])
      (plain "Mod+z" [(leaf "spawn" ["zen"])])
      (plain "Mod+D" [(leaf "spawn" ["walker"])])
      (plain "Super+Alt+L" [(leaf "spawn" ["swaylock"])])

      # You can also use a shell:
      # (plain "Mod+T" [(leaf "spawn" [ "bash" "-c" "notify-send hello && exec alacritty" ])])

      # Example volume keys mappings for PipeWire & WirePlumber.
      (plain "XF86AudioRaiseVolume" [(leaf "spawn" ["wpctl" "set-volume" "54" "0.1+"])])
      (plain "XF86AudioLowerVolume" [(leaf "spawn" ["wpctl" "set-volume" "54" "0.1-"])])

      (plain "Mod+Q" [(flag "close-window")])

      (plain "Mod+Left"   [(flag "focus-column-left")])
      (plain "Mod+Down"   [(flag "focus-window-down")])
      (plain "Mod+Up"     [(flag "focus-window-up")])
      (plain "Mod+Right"  [(flag "focus-column-right")])
      (plain "Mod+H"      [(flag "focus-column-left")])
      (plain "Mod+J"      [(flag "focus-window-down")])
      (plain "Mod+K"      [(flag "focus-window-up")])
      (plain "Mod+L"      [(flag "focus-column-right")])

      (plain "Mod+Ctrl+Left"  [(flag "move-column-left")])
      (plain "Mod+Ctrl+Down"  [(flag "move-window-down")])
      (plain "Mod+Ctrl+Up"    [(flag "move-window-up")])
      (plain "Mod+Ctrl+Right" [(flag "move-column-right")])
      (plain "Mod+Ctrl+H"     [(flag "move-column-left")])
      (plain "Mod+Ctrl+J"     [(flag "move-window-down")])
      (plain "Mod+Ctrl+K"     [(flag "move-window-up")])
      (plain "Mod+Ctrl+L"     [(flag "move-column-right")])

      # Alternative commands that move across workspaces when reaching
      # the first or last window in a column.
      # (plain "Mod+J"      [(flag "focus-window-or-workspace-down")])
      # (plain "Mod+K"      [(flag "focus-window-or-workspace-up")])
      # (plain "Mod+Ctrl+J" [(flag "move-window-down-or-to-workspace-down")])
      # (plain "Mod+Ctrl+K" [(flag "move-window-up-or-to-workspace-up")])

      (plain "Mod+Home"       [(flag "focus-column-first")])
      (plain "Mod+End"        [(flag "focus-column-last")])
      (plain "Mod+Ctrl+Home"  [(flag "move-column-to-first")])
      (plain "Mod+Ctrl+End"   [(flag "move-column-to-last")])

      (plain "Mod+Shift+Left"   [(flag "focus-monitor-left")])
      (plain "Mod+Shift+Down"   [(flag "focus-monitor-down")])
      (plain "Mod+Shift+Up"     [(flag "focus-monitor-up")])
      (plain "Mod+Shift+Right"  [(flag "focus-monitor-right")])
      (plain "Mod+Shift+H"      [(flag "focus-monitor-left")])
      (plain "Mod+Shift+J"      [(flag "focus-monitor-down")])
      (plain "Mod+Shift+K"      [(flag "focus-monitor-up")])
      (plain "Mod+Shift+L"      [(flag "focus-monitor-right")])

      (plain "Mod+Shift+Ctrl+Left"  [(flag "move-column-to-monitor-left")])
      (plain "Mod+Shift+Ctrl+Down"  [(flag "move-column-to-monitor-down")])
      (plain "Mod+Shift+Ctrl+Up"    [(flag "move-column-to-monitor-up")])
      (plain "Mod+Shift+Ctrl+Right" [(flag "move-column-to-monitor-right")])
      (plain "Mod+Shift+Ctrl+H"     [(flag "move-column-to-monitor-left")])
      (plain "Mod+Shift+Ctrl+J"     [(flag "move-column-to-monitor-down")])
      (plain "Mod+Shift+Ctrl+K"     [(flag "move-column-to-monitor-up")])
      (plain "Mod+Shift+Ctrl+L"     [(flag "move-column-to-monitor-right")])

      # Alternatively, there are commands to move just a single window:
      # (plain "Mod+Shift+Ctrl+Left" [(flag "move-window-to-monitor-left")])
      # ...

      # And you can also move a whole workspace to another monitor:
      # (plain "Mod+Shift+Ctrl+Left" [(flag "move-workspace-to-monitor-left")])
      # ...

      (plain "Mod+Page_Down"      [(flag "focus-workspace-down")])
      (plain "Mod+Page_Up"        [(flag "focus-workspace-up")])
      (plain "Mod+U"              [(flag "focus-workspace-down")])
      (plain "Mod+I"              [(flag "focus-workspace-up")])
      (plain "Mod+Ctrl+Page_Down" [(flag "move-column-to-workspace-down")])
      (plain "Mod+Ctrl+Page_Up"   [(flag "move-column-to-workspace-up")])
      (plain "Mod+Ctrl+U"         [(flag "move-column-to-workspace-down")])
      (plain "Mod+Ctrl+I"         [(flag "move-column-to-workspace-up")])

      # Alternatively, there are commands to move just a single window:
      # (plain "Mod+Ctrl+Page_Down" [(flag "move-window-to-workspace-down")])
      # ...

      (plain "Mod+Shift+Page_Down"  [(flag "move-workspace-down")])
      (plain "Mod+Shift+Page_Up"    [(flag "move-workspace-up")])
      (plain "Mod+Shift+U"          [(flag "move-workspace-down")])
      (plain "Mod+Shift+I"          [(flag "move-workspace-up")])

      # You can refer to workspaces by index. However, keep in mind that
      # niri is a dynamic workspace system, so these commands are kind of
      # "best effort". Trying to refer to a workspace index bigger than
      # the current workspace count will instead refer to the bottommost
      # (empty) workspace.
      #
      # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
      # will all refer to the 3rd workspace.
      (plain "Mod+1" [(leaf "focus-workspace" 1)])
      (plain "Mod+2" [(leaf "focus-workspace" 2)])
      (plain "Mod+3" [(leaf "focus-workspace" 3)])
      (plain "Mod+4" [(leaf "focus-workspace" 4)])
      (plain "Mod+5" [(leaf "focus-workspace" 5)])
      (plain "Mod+6" [(leaf "focus-workspace" 6)])
      (plain "Mod+7" [(leaf "focus-workspace" 7)])
      (plain "Mod+8" [(leaf "focus-workspace" 8)])
      (plain "Mod+9" [(leaf "focus-workspace" 9)])
      (plain "Mod+Ctrl+1" [(leaf "move-column-to-workspace" 1)])
      (plain "Mod+Ctrl+2" [(leaf "move-column-to-workspace" 2)])
      (plain "Mod+Ctrl+3" [(leaf "move-column-to-workspace" 3)])
      (plain "Mod+Ctrl+4" [(leaf "move-column-to-workspace" 4)])
      (plain "Mod+Ctrl+5" [(leaf "move-column-to-workspace" 5)])
      (plain "Mod+Ctrl+6" [(leaf "move-column-to-workspace" 6)])
      (plain "Mod+Ctrl+7" [(leaf "move-column-to-workspace" 7)])
      (plain "Mod+Ctrl+8" [(leaf "move-column-to-workspace" 8)])
      (plain "Mod+Ctrl+9" [(leaf "move-column-to-workspace" 9)])

      # Alternatively, there are commands to move just a single window:
      # (plain "Mod+Ctrl+1" [(leaf "move-window-to-workspace" 1)])

      (plain "Mod+Comma"  [(flag "consume-window-into-column")])
      (plain "Mod+Period" [(flag "expel-window-from-column")])

      # There are also commands that consume or expel a single window to the side.
      # (plain "Mod+BracketLeft"  [(flag "consume-or-expel-window-left")])
      # (plain "Mod+BracketRight" [(flag "consume-or-expel-window-right")])

      (plain "Mod+R" [(flag "switch-preset-column-width")])
      (plain "Mod+F" [(flag "maximize-column")])
      (plain "Mod+Shift+F" [(flag "fullscreen-window")])
      (plain "Mod+C" [(flag "center-column")])

      # (leaf "set-column-width" "100") will make the column occupy 200 physical screen pixels.
      #(plain "Mod+Minus" [(leaf "set-column-width" "-10")])
      #(plain "Mod+Equal" [(leaf "set-column-width" "+10")])

      # Finer height adjustments when in column with other windows.
      #(plain "Mod+Shift+Minus" [(leaf "set-window-height" "-10")])
      #(plain "Mod+Shift+Equal" [(leaf "set-window-height" "+10")])

      # Actions to switch layouts.
      # Note: if you uncomment these, make sure you do NOT have
      # a matching layout switch hotkey configured in xkb options above.
      # Having both at once on the same hotkey will break the switching,
      # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
      # (plain "Mod+Space"       [(leaf "switch-layout" "next")])
      # (plain "Mod+Shift+Space" [(leaf "switch-layout" "prev")])

      (plain "Print" [(flag "screenshot")])
      (plain "Ctrl+Print" [(flag "screenshot-screen")])
      (plain "Alt+Print" [(flag "screenshot-window")])

      # The quit action will show a confirmation dialog to avoid accidental exits.
      # If you want to skip the confirmation dialog, set the flag like so:
      # (plain "Mod+Shift+E" [(leaf "quit" { skip-confirmation=true; })])
      (plain "Mod+Shift+E" [(flag "quit")])

      (plain "Mod+Shift+P" [(flag "power-off-monitors")])

      # This debug bind will tint all surfaces green, unless they are being
      # directly scanned out. It's therefore useful to check if direct scanout
      # is working.
      # (plain "Mod+Shift+Ctrl+T" [(flag "toggle-debug-tint")])
    ])

    # Settings for debugging. Not meant for normal use.
    # These can change or stop working at any point with little notice.
    (plain "debug" [
      # Make niri take over its DBus services even if it's not running as a session.
      # Useful for testing screen recording changes without having to relogin.
      # The main niri instance will *not* currently take back the services; so you will
      # need to relogin in the end.
      # (flag "dbus-interfaces-in-non-session-instances")

      # Wait until every frame is done rendering before handing it over to DRM.
      # (flag "wait-for-frame-completion-before-queueing")

      # Enable direct scanout into overlay planes.
      # May cause frame drops during some animations on some hardware.
      # (flag "enable-overlay-planes")

      # Disable the use of the cursor plane.
      # The cursor will be rendered together with the rest of the frame.
      # (flag "disable-cursor-plane")

      # Override the DRM device that niri will use for all rendering.
      # (leaf "render-drm-device" "/dev/dri/renderD129")

      # Enable the color-transformations capability of the Smithay renderer.
      # May cause a slight decrease in rendering performance.
      # (flag "enable-color-transformations-capability")

      # Emulate zero (unknown) presentation time returned from DRM.
      # This is a thing on NVIDIA proprietary drivers, so this flag can be
      # used to test that we don't break too hard on those systems.
      # (flag "emulate-zero-presentation-time")
    ])
  ];
}
