{
  lib,
  pkgs,
  ...
}:
let
  utils = import ../default.nix {
    inherit lib pkgs;
  };

  inherit (utils) mkWrapper mkAlias;

  zed-wrapper = mkWrapper {
    package = pkgs.zed-editor;
    name = "zeditor";

    runScript = ''
      for arg in "$@"; do
        case "$arg" in
          -h|--help)
            cat <<EOF
Zed Wrapped-Custom


USAGE:
    zeditor [OPTIONS] [PATH[:LINE[:COL]]...]

EXAMPLES:
    zeditor
        Open Zed.

    zeditor .
        Open a project directory.

    zeditor file.rs:10:5
        Open a file at line 10, column 5.

    zeditor -n file.txt
        Open in a new window.

    ps axf | zeditor -
        Read paths from stdin.

OPTIONS:
    -n, --new
        Open a new workspace.

    -r, --reuse
        Reuse an existing window.

    -a, --add
        Add paths to the current workspace.

    -w, --wait
        Wait until opened paths are closed.

        --foreground
        Run in the foreground (debug output).

        --diff <OLD> <NEW>
        Diff file pairs (repeatable).

        --user-data-dir <DIR>
        Override user data directory
        (default: $XDG_DATA_HOME/zed).

        --zed <PATH>
        Path to the Zed binary.

    -v, --version
        Print version and binary path.

    -h, --help
        Show this help.
EOF
            exit 0
            ;;
        esac
      done
    '';
  };

  zed = mkAlias {
    name = "zed";
    target = "${zed-wrapper}/bin/zeditor";
    args = "--reuse";
  };
in
{
  inherit zed zed-wrapper;
}
