{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
in
{
  options = {
    funkouna = {
      programs = {
        discord = {
          enable = mkEnableOption "Enable Discord client via nixcord";
        };
      };
    };
  };

  config = mkIf config.funkouna.programs.discord.enable {
    programs = {
      nixcord = {
        enable = true;
        discord = {
          enable = false;
        };
        vesktop = {
          enable = true;
        };
        config = {
          autoUpdate = false;
          autoUpdateNotification = false;
          plugins = {
            messageLogger = {
              ignoreBots = true;
              ignoreSelf = true;
            };
            mentionAvatars = {
              enable = true;
              showAtSymbol = true;
            };
            imageZoom = {
              enable = true;
              nearestNeighbour = true;
            };
            callTimer = {
              enable = true;
            };
            silentTyping = {
              enable = true;
            };
            voiceDownload = {
              enable = true;
            };
            voiceMessages = {
              enable = true;
            };
            whoReacted = {
              enable = true;
            };
            favoriteGifSearch = {
              enable = true;
            };
            fixCodeblockGap = {
              enable = true;
            };
            fixImagesQuality = {
              enable = true;
            };
            fixSpotifyEmbeds = {
              enable = true;
            };
            fixYoutubeEmbeds = {
              enable = true;
            };
            forceOwnerCrown = {
              enable = true;
            };
            friendInvites = {
              enable = true;
            };
            friendsSince = {
              enable = true;
            };
            copyEmojiMarkdown = {
              enable = true;
            };
            copyFileContents = {
              enable = true;
            };
            noProfileThemes = {
              enable = true;
            };
          };
        };
        vesktopConfig = {
          plugins = {
            webKeybinds = {
              enable = true;
            };
            webRichPresence = {
              enable = false;
            };
            webScreenShareFixes = {
              enable = true;
            };
          };
        };
        extraConfig = {
          arRPC = {
            enabled = false;
          };
          minimizeToTray = {
            enabled = false;
          };
          tray = {
            enabled = false;
          };
          hardwareAcceleration = {
            enabled = true;
          };
          videoAcceleration = {
            enabled = true;
          };
        };
      };
    };
  };
}
