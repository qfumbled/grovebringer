{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.spicetify.homeManagerModules.spicetify ];

  config = {
    spicetify = {
      enable = true;
      theme = {
        name = "Ziro";
        src = pkgs.fetchFromGitHub {
          owner = "ziroh";
          repo = "spicetify-themes";
          rev = "main";
          sha256 = "sha256-0000000000000000000000000000000000000000000000=";
        };
      };
      colorScheme = "dark";
      enabledExtensions = with inputs.spicetify.packages.${pkgs.system}.extensions; [
        fullAppDisplay
        hidePodcasts
        queueTime
      ];
    };
  };
}
