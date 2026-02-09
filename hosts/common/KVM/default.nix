_:
{
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      runAsRoot = false;
    };
  };

  users.users.jb.extraGroups = [ "libvirtd" ]; 
}
