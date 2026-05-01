{
  services.keyd = {
    enable = true;
    keyboards = {      
      bettercaps = {
        ids = [ "*" ];
        settings.main.capslock = "overload(control,esc)";
      };
    };
  };
}
