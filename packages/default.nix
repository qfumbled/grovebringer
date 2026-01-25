{
  lib ? {
    # ...
  },
  pkgs,
  ...
}:

let
  funkounaLib = if lib ? funkouna then lib.funkouna else { };
  readSubdirs = if lib ? funkouna then lib.funkouna.readSubdirs else (dir: [ ]);
  packageDirs = readSubdirs ./.;

  # Electron wrapper for Wayland
  mkElectronWayland = {
    package,
    name ? package.pname or package.name,
    extraFlags ? [
    ],
    extraEnv ? {},
    enableGPU ? true,
    enableVulkan ? false,
    enableTouch ? false,
    hideTitlebar ? false,
    disableVsync ? false,
  }:
    let
      baseFlags = [
        "--enable-features=UseOzonePlatform,WaylandWindowDecorations"
        "--ozone-platform=wayland"
      ] ++ lib.optionals enableGPU [
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
      ] ++ lib.optionals enableVulkan [
        "--enable-features=Vulkan"
      ] ++ lib.optionals enableTouch [
        "--touch-events=enabled"
      ] ++ lib.optionals hideTitlebar [
        "--enable-features=WaylandWindowDecorations"
      ] ++ lib.optionals disableVsync [
        "--disable-gpu-vsync"
      ] ++ extraFlags;

      baseEnv = {
        NIXOS_OZONE_WL = "1";
        GDK_BACKEND = "wayland,x11";
        QT_QPA_PLATFORM = "wayland;xcb";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      } // lib.optionalAttrs enableVulkan {
        ELECTRON_ENABLE_VULKAN = "1";
      } // extraEnv;
    in
    mkWrapper {
      inherit package name;
      arguments = baseFlags;
      env = baseEnv;
    };

  mkChromiumWayland = {
    package,
    name ? package.pname or package.name,
    extraFlags ? [
    ],
    extraEnv ? {},
    userDataDir ? null,
    enableGPU ? true,
    enableVulkan ? false,
    enableHardwareAccel ? true,
    disableFeatures ? [],
  }:
    let
      enabledFeatures = [
        "UseOzonePlatform"
        "WaylandWindowDecorations"
        "VaapiVideoDecoder"
        "VaapiVideoEncoder"
      ] ++ lib.optionals enableVulkan [ "Vulkan" ];

      baseFlags = [
        "--ozone-platform=wayland"
        "--enable-features=${lib.concatStringsSep "," enabledFeatures}"
      ] ++ lib.optionals (disableFeatures != []) [
        "--disable-features=${lib.concatStringsSep "," disableFeatures}"
      ] ++ lib.optionals enableGPU [
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
      ] ++ lib.optionals enableHardwareAccel [
        "--enable-accelerated-video-decode"
        "--enable-accelerated-video-encode"
      ] ++ lib.optionals (userDataDir != null) [
        "--user-data-dir=${userDataDir}"
      ] ++ extraFlags;

      baseEnv = {
        NIXOS_OZONE_WL = "1";
      } // extraEnv;
    in
    mkWrapper {
      inherit package name;
      arguments = baseFlags;
      env = baseEnv;
    };

  mkVSCodeWayland = {
    package,
    name ? package.pname or package.name,
    extraFlags ? [
    ],
    extraEnv ? {},
    enableGPU ? true,
  }:
    mkElectronWayland {
      inherit package name extraEnv enableGPU;
      extraFlags = [
        "--enable-features=WaylandWindowDecorations"
        "--ozone-platform-hint=auto"
      ] ++ extraFlags;
    };

  mkChatAppWayland = {
    package,
    name ? package.pname or package.name,
    extraFlags ? [
    ],
    extraEnv ? {},
    enableIME ? true,
  }:
    mkElectronWayland {
      inherit package name extraEnv;
      extraFlags = lib.optionals enableIME [ "--enable-wayland-ime" ] ++ extraFlags;
    };

  mkOverride = {
    package,
    override ? {
      # ...
    },
    overrideAttrs ? (old: {
      # ...
    }),
  }:
    (package.override override).overrideAttrs overrideAttrs;

  mkPatched = {
    package,
    patches ? [],
    postPatch ? "",
    prePatch ? "",
  }:
    package.overrideAttrs (old: {
      patches = (old.patches or []) ++ patches;
      postPatch = (old.postPatch or "") + postPatch;
      prePatch = (old.prePatch or "") + prePatch;
    });

  mkVersioned = {
    package,
    version,
    sha256,
    fetchurl ? pkgs.fetchurl,
  }:
    package.overrideAttrs (old: {
      inherit version;
      src = fetchurl {
        url = builtins.replaceStrings
          [ old.version or "0.0.0" ]
          [ version ]
          (old.src.url or "");
        inherit sha256;
      };
    });

  mkAlias = {
    name,
    target,
    args ? "",
  }:
    pkgs.writeShellScriptBin name ''
      exec ${target} ${args} "$@"
    '';

  mkAliases = aliases:
    lib.mapAttrs (name: target:
      if builtins.isString target then
        mkAlias { inherit name target; }
      else
        mkAlias { inherit name; inherit (target) target; args = target.args or ""; }
    ) aliases;

  mkShellScript =
    {
      name,
      script,
      runtimeInputs ? [ ],
    }:
    pkgs.writeShellScriptBin name script;

  mkApplicationWrapper =
    args@{
      name ? "",
      package ? null,
      wrapperArgs ? [ ],
      script ? "",
      env ? { },
      preHook ? "",
      postHook ? "",
      ...
    }:
    if script != "" then
      pkgs.writeShellApplication {
        inherit name;
        runtimeInputs = lib.optional (package != null) package;
        text = ''
          #!/usr/bin/env bash
          set -euo pipefail
          ${preHook}
          ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "export ${k}=${lib.escapeShellArg v}") env)}
          ${script}
        '';
      }
    else if package != null then
      mkWrapper ({
        inherit name package preHook postHook;
        arguments = wrapperArgs;
        inherit env;
      } // (builtins.removeAttrs args [ "name" "package" "wrapperArgs" "env" "preHook" "postHook" ]))
    else
      pkgs.writeShellApplication {
        inherit name;
        text = ''
          #!/usr/bin/env bash
          set -euo pipefail
          ${preHook}
          ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "export ${k}=${lib.escapeShellArg v}") env)}
          exec ${lib.escapeShellArgs wrapperArgs} "$@"
          ${postHook}
        '';
      };

  mkPinnedPackage =
    {
      name,
      url,
      sha256,
      buildInputs ? [ ],
    }:
    pkgs.fetchFromGitHub {
      inherit name url sha256;
    };

  mkDevShell =
    {
      name,
      packages ? [ ],
      buildInputs ? [ ],
      shellHook ? "",
    }:
    pkgs.mkShell {
      inherit name buildInputs;
      packages = packages;
      shellHook = shellHook;
    };

  mkBinaryWrapper =
    {
      name,
      package,
      binaryName ? name,
      extraArgs ? "",
      env ? { },
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

  mkScriptRunner =
    {
      name,
      scriptFile,
      runtimeInputs ? [ ],
    }:
    pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = builtins.readFile scriptFile;
    };

  mkConfigFile =
    {
      name,
      content,
      destination ? "/etc/${name}",
    }:
    pkgs.writeTextFile {
      inherit name content destination;
    };

  mkService =
    {
      name,
      description,
      exec,
      user ? "root",
      after ? [ ],
      wants ? [ ],
    }:
    pkgs.writeTextFile {
      name = "${name}.service";
      text = ''
        [Unit]
        Description=${description}
        ${lib.optionalString (after != [ ]) "After=${lib.concatStringsSep " " after}"}
        ${lib.optionalString (wants != [ ]) "Wants=${lib.concatStringsSep " " wants}"}
        [Service]
        ExecStart=${exec}
        User=${user}
        Restart=on-failure
        [Install]
        WantedBy=multi-user.target
      '';
      destination = "/etc/systemd/system/${name}.service";
    };

  mkWrapper =
    {
      package,
      name ? package.pname or package.name or "wrapper",
      binaryPath ? null,
      arguments ? [ ],
      env ? { },
      preHook ? "",
      postHook ? "",
      runScript ? "",
    }:
    let
      actualBinaryPath =
        if binaryPath != null then binaryPath
        else "$out/bin/${name}";

      argFlags =
        if arguments != [ ] then "--add-flags \"${lib.concatStringsSep " " arguments}\"" else "";
      envFlags = lib.concatStringsSep " " (lib.mapAttrsToList (k: v: "--set ${k} \"${v}\"") env);
      runFlag = if runScript != "" then "--run ${lib.escapeShellArg runScript}" else "";
      wrapperArgs = lib.concatStringsSep " " (lib.filter (s: s != "") [ argFlags envFlags runFlag ]);
    in
    pkgs.symlinkJoin {
      inherit (package) passthru;
      name = "${name}-wrapped";
      paths = [ package ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        ${preHook}
        UNWRAPPED=${actualBinaryPath}-unwrapped
        WRAPPED=${actualBinaryPath}
        if [ -e "$WRAPPED" ]; then
          mv $WRAPPED $UNWRAPPED
          makeWrapper $UNWRAPPED $WRAPPED ${wrapperArgs}
        fi
        ${postHook}
      '';
      meta = {
        mainProgram = name;
      } // (package.meta or {});
    };

  mkShell =
    {
      name,
      script,
      runtimeInputs ? [ ],
    }:
    pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = script;
    };

in
{
  imports = packageDirs;

  inherit
    mkElectronWayland
    mkChromiumWayland
    mkVSCodeWayland
    mkChatAppWayland

    mkOverride
    mkPatched
    mkVersioned

    mkAlias
    mkAliases

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
    ;
}
