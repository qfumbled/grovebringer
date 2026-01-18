{
  config,
  inputs,
  pkgs,
  ...
}:
{
  config = {
    programs = { 
      vicinae = {
        enable = true;
      };
    };
  };
}
