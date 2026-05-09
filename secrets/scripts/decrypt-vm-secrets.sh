#!/usr/bin/env bash
set -euo pipefail

VMID="$1"
SECRETS_DIR="/root/NixOS-config-files/secrets/VM-symlinks/$VMID"
OUT_DIR="/run/vm-secrets/$VMID"

mkdir -p "$OUT_DIR"
chmod 0700 "$OUT_DIR"

for secret in "$SECRETS_DIR"/*.age; do
  name=$(basename "$secret" .age)
  age -d -i /root/keys/host.age "$secret" > "$OUT_DIR/$name"
  chmod 0400 "$OUT_DIR/$name"
done