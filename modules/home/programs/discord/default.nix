{ config, pkgs, ... }:
{
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;
    config = {
      plugins = {
        alwaysAnimate.enable = true;
        anonymiseFileNames.enable = true;
        silentTyping.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        whoReacted.enable = true;
        betterFolders.enable = true;
        betterSettings.enable = true;
        #emoteCloner.enable = true;
        messageClickActions.enable = true;
        # hideAttachments.enable = true; # This plugin can crash when zooming images
        ignoreActivities = {
          # Enable a plugin and set some options
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
        };
      };
    };
  };
}