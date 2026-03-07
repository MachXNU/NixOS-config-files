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
      "ente/api-s3-b2-eu-cen-key" = {
        file = ../../secrets/ente-api-s3-b2-eu-cen-key.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/api-s3-b2-eu-cen-key";
        symlink = false;
      };
      "ente/api-s3-b2-eu-cen-secret" = {
        file = ../../secrets/ente-api-s3-b2-eu-cen-secret.age;
        mode = "400";
        owner = "microvm";
        group = "kvm";
        path = "/run/ente-vm/api-s3-b2-eu-cen-secret";
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
