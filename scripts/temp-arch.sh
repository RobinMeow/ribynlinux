#!/usr/bin/env bash
set -euo pipefail

# run with sudo, unless your
# user is added to docker group
docker run -it --rm archlinux:latest /bin/bash
