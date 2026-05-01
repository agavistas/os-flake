{ baseVars, ... }:

{
  hm.programs.git = {
    enable = true;
    settings.user = {
      name = "agavistas";
      email = "118552874+agavistas@users.noreply.github.com";
    };
  };
}
