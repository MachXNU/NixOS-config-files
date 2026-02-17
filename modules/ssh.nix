{ pkgs, lib, config, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      PermitEmptyPasswords = false;
      MaxAuthTries = 3;
      X11Forwarding = false;
      AllowTcpForwarding = false;
      AllowUsers = [ "jb" ];
    };
    extraConfig = "LoginGracetime 30s";
  };

  services.fail2ban = {
    enable = true;
    # Ban IP after 5 failures
    maxretry = 5;
    ignoreIP = [
      "192.168.0.0/16" # Whitelist a subne
    ];
    bantime = "24h"; # Ban IPs for one day on the first ban
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
    jails.sshd.settings = {
      enabled = true;
      port = "ssh";
      filter = "sshd";
      logpath = "/var/log/auth.log"; # or journal if using systemd
      backend = "systemd";
      maxretry = 5;
      findtime = 600;
      bantime = 600;
    };
  };
}
