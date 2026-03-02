{ config, pkgs, lib, ... }:

let
  # Time after idle until spindown (5 seconds * SPINDOWN_TIME)
  spindownScript = ''
    #!/usr/bin/env bash
    SPINDOWN_TIME="241"  # 30 minutes
    for device in /dev/sd{a-b}; do
      if [ "$(cat /sys/block/$(basename $device)/queue/rotational)" -eq 1 ]; then
        echo "Configuring spindown for HDD: $device"
        ${pkgs.hdparm}/bin/hdparm -S $SPINDOWN_TIME "$device"
      fi
    done
  '';
in
{
  # Install hdparm so the service can use it
  environment.systemPackages = [ pkgs.hdparm ];

  # Drop the script into /etc
  environment.etc."spindownScript.sh".text = spindownScript;

  # Create a systemd service that runs at boot, after suspend, and after resume
  systemd.services.hdparm = {
    description = "Service to spin down HDDs after a specified time in idle";
    wantedBy = [ "multi-user.target" "sleep.target" "post-resume.target" ];
    after = [ "network.target" "suspend.target" "post-resume.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = "${pkgs.bash}/bin/bash /etc/spindownScript.sh";
    };
  };
}
