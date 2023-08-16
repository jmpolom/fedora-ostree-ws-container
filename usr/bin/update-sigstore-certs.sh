#!/usr/bin/env bash

set -eux

# very much non standard; will this be a problem?
CONTAINER_PKI_DIR="/etc/pki/containers"

# Fulcio swagger docs: https://rekor.sigstore.dev/api/v1/log/publicKey
FULCIO_CERT_URL="https://fulcio.sigstore.dev/api/v2/trustBundle"

# Rekor swagger docs: https://rekor.sigstore.dev/api/v1/log/publicKey
REKOR_PUBKEY_URL="https://rekor.sigstore.dev/api/v1/log/publicKey"

[[ -d "$CONTAINER_PKI_DIR" ]] || mkdir -p "$CONTAINER_PKI_DIR"

curl -L "$FULCIO_CERT_URL" | jq -j '.chains[].certificates | join("")' > \
    "$CONTAINER_PKI_DIR"/fulcio.sigstore.dev.pub.tmp && \
    mv "$CONTAINER_PKI_DIR"/fulcio.sigstore.dev.pub.tmp \
    "$CONTAINER_PKI_DIR"/fulcio.sigstore.dev.pub && \
    cat "$CONTAINER_PKI_DIR"/fulcio.sigstore.dev.pub

curl -L -o "$CONTAINER_PKI_DIR"/rekor.sigstore.dev.pub "$REKOR_PUBKEY_URL" && \
    cat "$CONTAINER_PKI_DIR"/rekor.sigstore.dev.pub
