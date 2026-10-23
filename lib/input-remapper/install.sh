#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --assume-yes \
	input-remapper

sudo systemctl enable --now input-remapper
