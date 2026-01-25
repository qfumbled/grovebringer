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
    pname = "wmenu-solarized";
    version = "1.0";

    nativeBuildInputs = [ pkgs.makeWrapper ];
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin

      makeWrapper ${pkgs.wmenu}/bin/wmenu-run $out/bin/wmenu-run \
        --prefix PATH : ${path} \
        --add-flags "\
          -f '0xProto 12' \
          -N '002B36' \
          -n '063C4A' \
          -m '043643' \
          -s '657B83' \
          -S '93A1A1' \
          ${extraFlags} \
        "
    '';
  };
in
{
  inherit wmenu;
}
