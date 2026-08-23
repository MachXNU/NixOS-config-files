{
  username,
  ...
}:

{
  programs.nh = {
    enable = true;
    clean = {
      dates = "monthly";
    };
    flake = "/home/${username}/NixOS-config-files";
    darwinFlake = "/Users/${username}/NixOS-config-files";
  };
}
