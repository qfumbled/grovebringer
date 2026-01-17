{ 
  lib ? {},
  pkgs,
  ... 
}:

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
  
  # Simple wrapper utility (less strict)
  mkApplicationWrapper = args@{
    name ? "",
    package ? null,
    wrapperArgs ? "",
    script ? "",
    env ? {},
    preHook ? "",
    postHook ? "",
  }:
    let
      # Use provided script or generate default
      wrapperScript = if script != "" then script else ''
        #!/usr/bin/env bash
        set -euo pipefail
        
        # Pre-execution hook
        ${preHook}
        
        # Environment variables
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "export ${k}=\"${v}\"") env)}
        
        # Add package to PATH if provided
        ${lib.optionalString (package != null) ''
          export PATH="${package}/bin:$PATH"
          export MANPATH="${package}/share/man:$MANPATH"
        ''}
        
        # Execute the command
        ${if package != null then 
          ''exec ${package}/bin/${if name != "" then name else (package.pname or package.name or "unknown")} ${wrapperArgs} "$@"'' 
          else 
          ''${wrapperArgs} "$@"''
        }
        
        # Post-execution hook (never reached on exec)
        ${postHook}
      '';
    in
    pkgs.writeShellScriptBin (if name != "" then name else "wrapper") wrapperScript;
  
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
  
  # Development environment helper
  mkDevShell = {
    name,
    packages ? [],
    buildInputs ? [],
    shellHook ? "",
  }:
    pkgs.mkShell {
      inherit name buildInputs;
      packages = packages;
      shellHook = shellHook;
    };
  
  # Binary wrapper with makeWrapper
  mkBinaryWrapper = {
    name,
    package,
    binaryName ? name,
    extraArgs ? "",
    env ? {},
  }:
    pkgs.symlinkJoin {
      inherit name;
      paths = [ package ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/${binaryName} \
          ${lib.optionalString (extraArgs != "") "--add-flags \"${extraArgs}\""} \
          ${lib.concatStringsSep " " (lib.mapAttrsToList (k: v: "--set ${k} \"${v}\"") env)}
      '';
    };
  
  # Simple script runner
  mkScriptRunner = {
    name,
    scriptFile,
    runtimeInputs ? [],
  }:
    pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = builtins.readFile scriptFile;
    };
  
  # Configuration file helper
  mkConfigFile = {
    name,
    content,
    destination ? "/etc/${name}",
  }:
    pkgs.writeTextFile {
      inherit name content destination;
    };
  
  # Service helper
  mkService = {
    name,
    description,
    exec,
    user ? "root",
    after ? [],
    wants ? [],
  }:
    pkgs.writeTextFile {
      name = "${name}.service";
      text = ''
        [Unit]
        Description=${description}
        ${lib.optionalString (after != []) "After=${lib.concatStringsSep " " after}"}
        ${lib.optionalString (wants != []) "Wants=${lib.concatStringsSep " " wants}"}
        
        [Service]
        ExecStart=${exec}
        User=${user}
        Restart=on-failure
        
        [Install]
        WantedBy=multi-user.target
      '';
      destination = "/etc/systemd/system/${name}.service";
    };
  
  mkWrapper = {
    package,
    name ? package.pname or package.name or "wrapper",
    binaryPath ? "$out/bin/${name}",
    arguments ? [],
    env ? {},
    preHook ? "",
    postHook ? "",
  }:
    let
      argFlags = if arguments != [] then "--add-flags \"${lib.concatStringsSep " " arguments}\"" else "";
      envFlags = lib.concatStringsSep " " (lib.mapAttrsToList (k: v: "--set ${k} \"${v}\"") env);
      wrapperArgs = "${argFlags} ${envFlags}";
    in
    pkgs.symlinkJoin {
      inherit (package) passthru;
      name = "${name}-wrapped";
      paths = [package];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        UNWRAPPED=${binaryPath}-unwrapped
        WRAPPED=${binaryPath}
        mv $WRAPPED $UNWRAPPED

        makeWrapper $UNWRAPPED $WRAPPED ${wrapperArgs}
      '';
      meta.mainProgram = name;
    };
  
  # Shell application helper
  mkShell = {
    name,
    script,
    runtimeInputs ? [],
  }:
    pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = script;
    };
  
  # Spotify Wayland wrapper
  spotify-wayland = mkWrapper {
    package = pkgs.spotify;
    name = "spotify-wayland";
    arguments = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
    env = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";
    };
  };
in
{
  # Import all package directories
  imports = packageDirs;
  
  # Export utilities
  inherit 
    mkShellScript 
    mkApplicationWrapper 
    mkPinnedPackage
    mkDevShell
    mkBinaryWrapper
    mkScriptRunner
    mkConfigFile
    mkService
    mkWrapper
    mkShell
    spotify-wayland;
}