{
  age = {
    secrets = {
      # mySecret = {
      #   file = ../../secrets/mySecret.age;
      # };
      "ente/garage-rpc-secret" = {
        file = ../../secrets/garage-rpc-secret.age;
        mode = "400";
        owner = "admin";
        group = "users";
        path = "/run/secrets/garage-rpc-secret";
        symlink = false;
      };
      "ente/garage-admin-token" = {
        file = ../../secrets/garage-admin-token.age;
        mode = "400";
        owner = "admin";
        group = "users";
        path = "/run/secrets/garage-admin-token";
        symlink = false;
      };
      "ente/garage-metrics-token" = {
        file = ../../secrets/garage-metrics-token.age;
        mode = "400";
        owner = "admin";
        group = "users";
        path = "/run/secrets/garage-metrics-token";
        symlink = false;
      };
    };
  };
}
