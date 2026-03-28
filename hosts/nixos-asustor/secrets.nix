{
  age = {
    secrets = {
      # mySecret = {
      #   file = ../../secrets/mySecret.age;
      # };
      "ddns-updater-config-json" = {
        file = ../../secrets/ddns-updater-config-json.age;
        mode = "400";
        owner = "ddns";
        group = "ddns";
      };
      "ente/garage-rpc-secret" = {
        file = ../../secrets/garage-rpc-secret.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/garage-rpc-secret";
        symlink = false;
      };
      "ente/garage-admin-token" = {
        file = ../../secrets/garage-admin-token.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/garage-admin-token";
        symlink = false;
      };
      "ente/garage-metrics-token" = {
        file = ../../secrets/garage-metrics-token.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/garage-metrics-token";
        symlink = false;
      };
      "ente/api-key-encryption" = {
        file = ../../secrets/ente-api-key-encryption.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/api-key-encryption";
        symlink = false;
      };
      "ente/api-key-hash" = {
        file = ../../secrets/ente-api-key-hash.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/api-key-hash";
        symlink = false;
      };
      "ente/postgres-pguser-password" = {
        file = ../../secrets/ente-postgres-pguser-password.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/postgres-pguser-password";
        symlink = false;
      };
      "ente/ente-garage-key" = {
        file = ../../secrets/ente-garage-key.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/ente-garage-key";
        symlink = false;
      };
      "ente/ente-garage-secret" = {
        file = ../../secrets/ente-garage-secret.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/ente-garage-secret";
        symlink = false;
      };
      "ente/api-jwt-secret" = {
        file = ../../secrets/ente-api-jwt-secret.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/api-jwt-secret";
        symlink = false;
      };
    };
  };
}
