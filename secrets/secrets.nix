let
  asustor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqZ1H6r1CiYmibRCWQkY/mEnbsrSQf69OoBA/uGv9b2";
in
{
  # Generate with nix run github:ryantm/agenix -- -e mySecret.age
  # "mySecret.age" = {
  #   publicKeys = [ asustor ];
  #   armor = true;
  # };
  "ddns-updater-config-json.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
  "garage-rpc-secret.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
  "garage-admin-token.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
  "garage-metrics-token.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
  "ente-postgres-pguser-password.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
  "ente-garage-key.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
  "ente-garage-secret.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
  "ente-api-key-encryption.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
  "ente-api-key-hash.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
  "ente-api-jwt-secret.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
}
