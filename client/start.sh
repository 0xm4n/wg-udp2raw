#!/bin/bash

PEER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
wg-quick up "$PEER_DIR"/wg0.conf
sudo wg show