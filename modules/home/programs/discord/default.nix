{
  config,
  pkgs,
  ...
}:

{
  programs = {
    nixcord = {
      enable = true;

      discord.enable = true;
      vesktop.enable = false;

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
          # emoteCloner.enable = true;
          messageClickActions.enable = true;
          # hideAttachments.enable = true; # This plugin can crash when zooming images

          ignoreActivities = {
            enable = true;
            ignorePlaying = true;
            ignoreWatching = true;
          };
        };
      };
    };
  };
}
