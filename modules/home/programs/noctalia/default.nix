#+TITLE: Noctalia 14" Ultra-Compact
#+AUTHOR: xander h.
#+DATE: Jan 24 2026

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
          enable = mkEnableOption "Noctalia Shell ultra-compact for 14-inch screen";
        };
      };
    };
  };

  config = mkIf config.funkouna.programs.noctalia.enable {
    programs = {
      noctalia-shell = {
        enable = true;

        settings = {
          settingsVersion = 0;

          bar = {
            position = "left";
            density = "comfortable";
            height = 32;             # smaller than default
            showOutline = false;
            showCapsule = true;
            capsuleOpacity = mkDefault 0.9;
            backgroundOpacity = mkDefault 0.85;
            floating = false;
            marginVertical = 2;      # smaller margin
            marginHorizontal = 2;
            outerCorners = true;
            exclusive = true;
            hideOnOverview = false;

            widgets = {
              left = [
                { id = "ControlCenter"; useDistroLogo = true; }
                { id = "Workspace"; hideUnoccupied = true; labelMode = "none"; }
              ];

              center = [ ];

              right = [
                { id = "Battery"; alwaysShowPercentage = true; warningThreshold = 25; }
                { id = "Network"; }
                { id = "Volume"; }
                { id = "Bluetooth";}
                { id = "Clock"; formatHorizontal = "HH:mm"; useMonospacedFont = true; fontSize = 11; }
              ];
            };
          };

          dock = {
            enabled = true;
            position = "bottom";
            displayMode = "auto_hide";
            backgroundOpacity = mkForce 0.85;
            size = 0.9;              # slightly smaller
            colorizeIcons = true;
            pinnedStatic = false;
            inactiveIndicators = false;
            deadOpacity = 0.6;
            animationSpeed = 0.7;
            pinnedApps = [ "zen-beta.desktop" ];
          };

          general = {
            avatarImage = "/home/${username}/.face";
            radiusRatio = 0.15;
            dimmerOpacity = 0.15;
            enableShadows = true;
            shadowDirection = "bottom_right";
            shadowOffsetX = 1;
            shadowOffsetY = 2;
            telemetryEnabled = false;
            scaleRatio = 0.95;
            animationSpeed = 0.9;
          };

          ui = {
            tooltipsEnabled = true;
            panelBackgroundOpacity = mkDefault 0.85;
            panelsAttachedToBar = true;
            settingsPanelMode = "attached";
          };

          notifications = {
            enabled = true;
            location = "bottom_right";
            overlayLayer = true;
            backgroundOpacity = mkForce 0.9;
            lowUrgencyDuration = 4;
            normalUrgencyDuration = 8;
            criticalUrgencyDuration = 15;
          };

          systemMonitor = {
            cpuPollingInterval = 2500;
            gpuPollingInterval = 3500;
            memPollingInterval = 3500;
            diskPollingInterval = 6000;
            networkPollingInterval = 3500;
          };
        };
      };
    };
  };
}
