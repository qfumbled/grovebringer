{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkDefault mkForce;
in
{
  options = {
    funkouna = {
      programs = {
        noctalia = {
          enable = mkEnableOption "Noctalia Shell matching your UI";
        };
      };
    };
  };

  config = mkIf config.funkouna.programs.noctalia.enable {
    stylix = {
      targets = {
        noctalia-shell = {
          enable = true;
        };
      };
    };

    programs = {
      noctalia-shell = {
        enable = true;

        settings = {
          settingsVersion = 0;

          bar = {
            position = "top";
            density = "comfortable";
            showOutline = false;
            showCapsule = true;
            capsuleOpacity = mkDefault 1;
            backgroundOpacity = mkDefault 0.93;
            useSeparateOpacity = false;
            floating = false;
            marginVertical = 4;
            marginHorizontal = 8;
            outerCorners = true;
            exclusive = true;
            hideOnOverview = false;

            widgets = {
              left = [
                {
                  id = "ControlCenter";
                  useDistroLogo = true;
                }
                {
                  id = "Workspace";
                  hideUnoccupied = true;
                  labelMode = "none";
                }
                {
                  id = "SystemMonitor";
                }
              ];

              center = [ ];

              right = [
                {
                  id = "Battery";
                  alwaysShowPercentage = true;
                  warningThreshold = 25;
                }
                {
                  id = "Network";
                }
                {
                  id = "Bluetooth";
                }
                {
                  id = "Volume";
                }
                {
                  id = "Clock";
                  formatHorizontal = "HH:mm";
                  useMonospacedFont = true;
                  usePrimaryColor = true;
                }
                {
                  id = "NotificationHistory";
                }
              ];
            };
          };

          dock = {
            enabled = true;
            position = "bottom";
            displayMode = "auto_hide";
            backgroundOpacity = mkForce 0.9;
            size = 1.1;
            colorizeIcons = true;
            pinnedStatic = false;
            inactiveIndicators = false;
            deadOpacity = 0.6;
            animationSpeed = 0.8;
            pinnedApps = [
              "zen-beta.desktop"
            ];
          };

          plugins = {
            states = {
              catwalk = {
                enabled = true;
                sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
              };
              screenshot = {
                enabled = true;
                sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
              };
              screenrecorder = {
                enabled = true;
                sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
              };
              pomodoro = {
                enabled = true;
                sourceUrl = "https://github.com/pvlvld/noctalia-plugins";
              };
            };
            version = 1;
          };

          pluginSettings = {
            catwalk = {
              minimumThreshold = 20;
              hideBackground = false;
            };
          };

          general = {
            avatarImage = "/home/${username}/.face";
            radiusRatio = 0.2;
            dimmerOpacity = 0.2;
            lockOnSuspend = true;
            showSessionButtonsOnLockScreen = true;
            enableShadows = true;
            shadowDirection = "bottom_right";
            shadowOffsetX = 2;
            shadowOffsetY = 3;
            telemetryEnabled = false;
            scaleRatio = 1.0;
            animationSpeed = 1;
          };

          ui = {
            tooltipsEnabled = true;
            panelBackgroundOpacity = mkDefault 0.93;
            panelsAttachedToBar = true;
            settingsPanelMode = "attached";
            wifiDetailsViewMode = "grid";
            bluetoothDetailsViewMode = "grid";
            networkPanelView = "wifi";
            bluetoothHideUnnamedDevices = false;
            boxBorderEnabled = false;
          };

          location = {
            name = "Budapest, HU";
            weatherEnabled = true;
            weatherShowEffects = true;
            useFahrenheit = false;
            use12hourFormat = false;
            monthBeforeDay = true;
            showCalendarEvents = true;
            showCalendarWeather = true;
          };

          appLauncher = {
            position = "center";
            viewMode = "list";
            showCategories = true;
            iconMode = "tabler";
            showIconBackground = true;
            enableClipboardHistory = true;
            autoPasteClipboard = false;
            enableClipPreview = true;
            clipboardWrapText = true;
            terminalCommand = "foot -e";
          };

          controlCenter = {
            position = "close_to_bar_button";
            shortcuts = {
              left = [
                {
                  id = "Network";
                }
                {
                  id = "Bluetooth";
                }
                {
                  id = "WallpaperSelector";
                }
                {
                  id = "SystemMonitor";
                }
                {
                  id = "Screenshot";
                }
              ];
              right = [
                {
                  id = "Notifications";
                }
                {
                  id = "PowerProfile";
                }
                {
                  id = "KeepAwake";
                }
                {
                  id = "NightLight";
                }
                {
                  id = "Location";
                }
              ];
            };
          };

          notifications = {
            enabled = true;
            location = "bottom_right";
            overlayLayer = true;
            backgroundOpacity = mkForce 0.95;
            lowUrgencyDuration = 5;
            normalUrgencyDuration = 10;
            criticalUrgencyDuration = 20;
            enableMediaToast = true;
            sounds = {
              enabled = false;
              volume = 0.3;
              excludedApps = "discord,firefox,chrome,chromium,edge,spotify";
            };
            saveToHistory = {
              low = true;
              normal = true;
              critical = true;
            };
          };

          systemMonitor = {
            cpuWarningThreshold = 75;
            cpuCriticalThreshold = 90;
            tempWarningThreshold = 80;
            tempCriticalThreshold = 90;
            gpuWarningThreshold = 75;
            gpuCriticalThreshold = 90;
            memWarningThreshold = 80;
            memCriticalThreshold = 90;
            diskWarningThreshold = 85;
            diskCriticalThreshold = 95;
            cpuPollingInterval = 2000;
            gpuPollingInterval = 3000;
            memPollingInterval = 3000;
            diskPollingInterval = 5000;
            networkPollingInterval = 3000;
            enableDgpuMonitoring = false;
            useCustomColors = false;
          };

          audio = {
            volumeStep = 5;
            volumeOverdrive = false;
            cavaFrameRate = 30;
            visualizerType = "linear";
          };

          brightness = {
            brightnessStep = 5;
            enforceMinimum = true;
            enableDdcSupport = false;
          };

          sessionMenu = {
            enableCountdown = true;
            countdownDuration = 10000;
            position = "center";
            showHeader = true;
            largeButtonsStyle = false;
            largeButtonsLayout = "grid";
            showNumberLabels = true;
          };

          osd = {
            enabled = true;
            location = "top_right";
            autoHideMs = 2000;
            overlayLayer = true;
            backgroundOpacity = mkForce 1;
            enabledTypes = [ 0 1 2 ];
          };

          nightLight = {
            enabled = false;
            autoSchedule = true;
            nightTemp = "4500";
            dayTemp = "6500";
          };

          desktopWidgets = {
            enabled = false;
          };

          wallpaper = {
            enabled = true;
            overviewEnabled = false;
            directory = "/home/${username}/Pictures/Wallpapers";
            recursiveSearch = true;
            setWallpaperOnAllMonitors = true;
            fillMode = "fill";
            randomEnabled = true;
            wallpaperChangeMode = "random";
            randomIntervalSec = 3600;
            transitionDuration = 2000;
            transitionType = "random";
          };
        };
      };
    };
  };
}
