let
  hyprlockMonitor = "eDP-1";
in
{
  hour = {
    position = "-8%, 26%";
    halign = "center";
    valign = "center";
    font_size = 180;
    monitor = hyprlockMonitor;
  };

  minute = {
    position = "0, 9%";
    halign = "center";
    valign = "center";
    font_size = 180;
    monitor = hyprlockMonitor;
  };

  date = {
    position = "2%, -1%";
    halign = "center";
    valign = "center";
    font_size = 20;
    monitor = hyprlockMonitor;
  };

  user = {
    font_size = 20;
    position = "0, -38%";
    halign = "center";
    valign = "center";
    monitor = hyprlockMonitor;
  };

  image = {
    size = 100;
    position = "0, -30%";
    halign = "center";
    valign = "center";
    monitor = hyprlockMonitor;
  };

  input = {
    size = "300, 55";
    position = "0, -43%";
    halign = "center";
    valign = "center";
    fade_on_empty = true;
    fade_timeout = 0;
    monitor = hyprlockMonitor;
  };
  auth = {
    fingerprint = {
      enabled = true;
      retry_delay = 250;
    };
  };
}
