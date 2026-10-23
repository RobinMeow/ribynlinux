#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assumeyes \
	input-remapper

sudo systemctl enable --now input-remapper
