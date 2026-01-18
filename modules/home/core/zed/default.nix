{
  pkgs,
  ...
}:

{
  programs = {
    zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "toml"
        "rust"
        "python"
        "fish"
        "bash"
      ];
      userSettings = {
        disable_ai = false;
        lsp = {
          nil = {
            binary = {
              path_lookup = true;
            };
          };
        };
        languages = {
          Nix = {
            language_servers = [
              "nil"
              "!nixd"
            ];
            format_on_save = "off";
          };
        };
        load_direnv = "shell_hook";
        vim_mode = false;
      };
      extraPackages = with pkgs; [
        nil
        alejandra
      ];
      installRemoteServer = true;
    };
  };

  stylix = {
    targets = {
      zed = {
        enable = true;
      };
    };
  };
}
