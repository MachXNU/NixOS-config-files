{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    pywalfox-native
  ];


  home.file.".mozilla/native-messaging-hosts/pywalfox.json".text = 
    lib.generators.toJSON {} {
      name = "pywalfox";
      description = "Pywalfox native host";
      path = "${pkgs.pywalfox-native}/bin/pywalfox";
      type = "stdio";
      allowed_extensions = [ "pywalfox@frewacom.org" ];
    };
}
