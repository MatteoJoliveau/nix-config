{ lib, ... }:

with lib;
let
  ids = map (id: {
    inherit id;
  });
in
{
  xdg.dataFile."pam.d/quickshell".text = ''
    auth       required  pam_unix.so
    account    required  pam_unix.so
    password   required  pam_unix.so
    session    required  pam_unix.so
  '';

  programs.noctalia-shell = {
    settings = {
      general = {
        avatarImage = ../../../images/propic.jpg;
      };

      dock.enabled = false;
      network.wifiEnabled = false;

      colorSchemes = {
        darkMode = true;
        predefinedScheme = "Tokyo Night";
        schedulingMode = "off";
        useWallpaperColors = false;
        generateTemplatesForPredefined = true;
      };

      bar = {
        density = "default";
        exclusive = true;
        outerCorners = false;
        position = "top";
        showCapsule = true;

        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "MediaMini";
              hideWhenIdle = false;
              hideMode = "hidden";
              showAlbumArt = true;
              showVisualizer = true;
              maxWidth = 145;
            }
            {
              id = "Workspace";
              labelMode = "index";
              hideUnoccupied = false;
            }
          ];
          center = [
            {
              id = "Clock";
              formatVertical = "HH mm - dd MM";
              formatHorizontal = "HH:mm ddd, MMM dd";
            }
          ];
          right = [
            {
              id = "Tray";
              drawerEnabled = true;
            }
            {
              id = "NotificationHistory";
              hideWhenZero = true;
              showUnreadBadge = true;
            }
            {
              id = "KeepAwake";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "WiFi";
              displayMode = "alwaysShow";
            }
            {
              id = "Brightness";
              displayMode = "onhover";
            }
            {
              id = "Volume";
              displayMode = "alwaysShow";
            }
            {
              id = "Battery";
              displayMode = "alwaysShow";
              warningThreshold = 20;
            }
            {
              id = "SessionMenu";
            }
          ];
        };
      };

      controlCenter = {
        position = "close_to_bar_button";

        cards =
          map
            (id: {
              inherit id;
              enabled = true;
            })
            [
              "profile-card"
              "shortcuts-card"
              "audio-card"
              "media-sysmon-card"
            ];

        shortcuts = {
          left = ids [
            "WiFi"
            "Bluetooth"
            "Notifications"
          ];
          right = ids [
            "PowerProfile"
            "KeepAwake"
            "NightLight"
          ];
        };
      };

      nightLight = {
        enabled = true;
        autoSchedule = true;
        dayTemp = "6500";
        nightTemp = "4000";
      };

      notifications = {
        enabled = true;
        location = "top_right";
        overlayLayer = true;
      };

      wallpaper = {
        enabled = true;
        overviewEnabled = true;
        defaultWallpaper = ../../../images/wallpaper.png;
        setWallpaperOnAllMonitors = true;
      };
    };

    colors = {
      mError = "#f7768e";
      mHover = "#9ece6a";
      mOnError = "#16161e";
      mOnHover = "#16161e";
      mOnPrimary = "#16161e";
      mOnSecondary = "#16161e";
      mOnSurface = "#c0caf5";
      mOnSurfaceVariant = "#9aa5ce";
      mOnTertiary = "#16161e";
      mOutline = "#565f89";
      mPrimary = "#7aa2f7";
      mSecondary = "#bb9af7";
      mShadow = "#15161e";
      mSurface = "#1a1b26";
      mSurfaceVariant = "#24283b";
      mTertiary = "#9ece6a";
    };
  };
}
