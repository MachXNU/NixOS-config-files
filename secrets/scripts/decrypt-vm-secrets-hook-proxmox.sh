#!/usr/bin/env bash

PHASE="$2"
VMID="$1"

case "$PHASE" in
  pre-start)
    /root/NixOS-config-files/secrets/scripts/decrypt-vm-secrets.sh "$VMID"
    ;;
  post-stop)
    rm -rf "/run/vm-secrets/$VMID/*"
    ;;
esac