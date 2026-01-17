lib: pkgs: {
  funkouna = rec {
    inherit (lib.modules) mkIf mkMerge mkDefault;
    inherit (lib.lists)
      all
      unique
      concatLists
      head
      tail
      isList
      isString
      last
      baseNameOf
      ;
    inherit (lib.attrsets) zipAttrsWith isAttrs;

    mkIfElse =
      p: yes: no:
      mkMerge [
        (mkIf p yes)
        (mkIf (!p) no)
      ];

    readSubdirs =
      basePath:
      let
        # Check if path exists first
        pathCheck = builtins.dirOf basePath;
        isDirectory = 
          if builtins.pathExists basePath
          then (builtins.readDir basePath) != null
          else false;
      in
      if !builtins.pathExists basePath then
        []
      else if !isDirectory then
        []
      else
        let
          dirs = builtins.attrNames (
            lib.attrsets.filterAttrs (_: type: type == "directory") (builtins.readDir basePath)
          );
          dirPaths = map (d: basePath + "/${d}") dirs;
        in
        dirPaths;

    recursiveMerge =
      attrList:
      if attrList == [] then {} else
      let
        f =
          attrPath:
          zipAttrsWith (
            n: values:
            if tail values == [ ] then
              head values
            else if all isList values then
              unique (concatLists values)
            else if all isAttrs values then
              f (attrPath ++ [ n ]) values
            else
              last values
          );
      in
      f [ ] attrList;

    enableModules =
      moduleNames:
      if !all isString moduleNames then
        builtins.throw "enableModules: All module names must be strings"
      else
        moduleNames
        |> (builtins.map (m: {
          name = m;
          value = {
            enable = true;
          };
        }))
        |> (builtins.listToAttrs);

    flattenAttrs =
      prefix: delim: attrs:
      if !isAttrs attrs then
        builtins.throw "flattenAttrs: Second argument must be an attribute set"
      else
        attrs
        |> builtins.mapAttrs (
          key: value:
            let
              newPrefix = if prefix == "" then key else "${prefix}${delim}${key}";
            in
            if builtins.isAttrs value then flattenAttrs newPrefix delim value else [ newPrefix ]
        )
        |> builtins.attrValues
        |> builtins.concatLists;

    fromYAML =
      yaml:
      if !isString yaml then
        builtins.throw "fromYAML: Input must be a string"
      else if yaml == "" then
        builtins.throw "fromYAML: Input cannot be empty"
      else
        pkgs.runCommand "from-yaml"
          {
            inherit yaml;
            allowSubstitutes = false;
            preferLocalBuild = true;
          }
          ''
            ${pkgs.remarshal}/bin/remarshal \
              -if yaml \
              -i <(echo "$yaml") \
              -of json \
              -o $out
          ''
        |> builtins.readFile
        |> builtins.fromJSON;

    readYAML = 
      path:
      if !builtins.pathExists path then
        builtins.throw "readYAML: File '${path}' does not exist"
      else
        fromYAML (builtins.readFile path);
  };
}
