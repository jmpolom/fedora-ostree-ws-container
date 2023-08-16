#!/usr/bin/env bash

set -eux

CONTAINER_POLICY_DIR="/etc/containers"

jq -s 'reduce .[] as $x ({}; . * $x)' \
    "$CONTAINER_POLICY_DIR"/policy.json \
    "$CONTAINER_POLICY_DIR"/policy-mods.json | \
    tee "$CONTAINER_POLICY_DIR"/policy.json.tmp && \
    mv "$CONTAINER_POLICY_DIR"/policy.json.tmp "$CONTAINER_POLICY_DIR"/policy.json
