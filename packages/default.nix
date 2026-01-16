{ lib ? {}, pkgs, ... }:

let
  # Use passed lib or fallback to empty
  funkounaLib = if lib ? funkouna then lib.funkouna else {};
  readSubdirs = if lib ? funkouna then lib.funkouna.readSubdirs else (dir: []);
  packageDirs = readSubdirs ./.;
  
  # Utility for shell script packages
  mkShellScript = {
    name,
    script,
    runtimeInputs ? [],
  }:
    pkgs.writeShellScriptBin name script;
  
  # Simple wrapper utility
  mkApplicationWrapper = {
    name,
    package,
    wrapperArgs ? "",
  }:
    let
      wrapperScript = ''
        #!/usr/bin/env bash
        
        # Add package to PATH
        export PATH="${package}/bin:$PATH"
        
        # Preserve man pages
        export MANPATH="${package}/share/man:$MANPATH"
        
        exec ${package}/bin/${name} ${wrapperArgs} "$@"
      '';
    in
    pkgs.writeShellScriptBin name wrapperScript;
  
  # Simple pinned package utility
  mkPinnedPackage = {
    name,
    url,
    sha256,
    buildInputs ? [],
  }:
    pkgs.fetchFromGitHub {
      inherit name url sha256;
    };
in
{
  # Import all package directories
  imports = packageDirs;
  
  # Export utilities
  inherit 
    mkShellScript 
    mkApplicationWrapper 
    mkPinnedPackage;
}
