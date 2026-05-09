let
  asustor-proxmox = "age1vdr0epknmnj4lcvp2t09sgvml3c42lxu722yc6sfge666m7pcgzqrup3ar";
  hpomen-proxmox = "age13hwu4yz6vff6kayjxpfczqe6uzhvynqtc83pfnlpjtucuvkhmphqct95uh";
in
{
  # Generate with nix run github:ryantm/agenix -- -e mySecret.age
  # "mySecret.age" = {
  #   publicKeys = [ asustor ];
  #   armor = true;
  # };
  "ddns-updater-config-json.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
  "garage-rpc-secret.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
  "garage-admin-token.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
  "garage-metrics-token.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
  "ente-postgres-pguser-password.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
  "ente-garage-key.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
  "ente-garage-secret.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
  "ente-api-key-encryption.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
  "ente-api-key-hash.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
  "ente-api-jwt-secret.age" = {
    publicKeys = [ asustor-proxmox hpomen-proxmox ];
    armor = true;
  };
}
