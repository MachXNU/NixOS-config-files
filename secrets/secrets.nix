let
  vm-garage-1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP3bEXatfkW8peYrGrLRCBkmRv5P8ETBDXNWNZXUQcH7";
in
{
  # Generate with nix run github:ryantm/agenix -- -e mySecret.age
  # "mySecret.age" = {
  #   publicKeys = [ asustor ];
  #   armor = true;
  # };
  "ddns-updater-config-json.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
  "garage-rpc-secret.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
  "garage-admin-token.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
  "garage-metrics-token.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
  "ente-postgres-pguser-password.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
  "ente-garage-key.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
  "ente-garage-secret.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
  "ente-api-key-encryption.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
  "ente-api-key-hash.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
  "ente-api-jwt-secret.age" = {
    publicKeys = [ vm-garage-1 ];
    armor = true;
  };
}
