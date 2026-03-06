{
  age = {
    secrets = {
      # mySecret = {
      #   file = ../../secrets/mySecret.age;
      # };
      "ddns-updater/config.json" = {
        file = ../../secrets/ddns-updater-config-json.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ddns-vm/config.json";
        symlink = false;
      };
      "ente/minio-credentials" = {
        file = ../../secrets/minio-credentials.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/minio-credentials";
        symlink = false;
      };
    };
  };
}
