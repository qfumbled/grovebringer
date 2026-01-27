{
  pkgs,
  lib,
  extraFlags ? "",
  extraDeps ? [
    # ...
  ],
  ...
}:

let
  deps = [ pkgs.wmenu ] ++ extraDeps;
  path = lib.makeBinPath deps;

  wmenu = pkgs.stdenv.mkDerivation {
    pname = "wmenu-solarized-light";
    version = "1.0";

    nativeBuildInputs = [ pkgs.makeWrapper ];
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin

      makeWrapper ${pkgs.wmenu}/bin/wmenu-run $out/bin/wmenu-run \
        --prefix PATH : ${path} \
        --add-flags "\
          -f '0xProto 12' \
          -N '002b36' \
          -n '839496' \
          -m '93a1a1' \
          -s '073642' \
          -S 'eee8d5' \
          ${extraFlags} \
        "
    '';
  };
in
{
  inherit wmenu;
}
