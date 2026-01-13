{ pkgs }:

pkgs.writeShellScriptBin "gcp" ''
  if [ -z "$1" ]; then
    echo "usage: gcp \"commit message\""
    exit 1
  fi

  git add --all
  git commit -m "$1"
  git push --force-with-lease
''
