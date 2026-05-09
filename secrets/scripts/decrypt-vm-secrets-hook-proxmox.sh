#!/usr/bin/env bash

PHASE="$2"
VMID="$1"

case "$PHASE" in
  pre-start)
    /usr/local/bin/decrypt-vm-secrets "$VMID"
    ;;
  post-stop)
    rm -rf "/run/vm-secrets/$VMID"
    ;;
esac