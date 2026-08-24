#!/usr/bin/env bash
set -euo pipefail

# https://github.com/microsoft/playwright/issues/29559#issuecomment-4753194699

# WARN: I already have free enabled usually.
# sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-44.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-44.noarch.rpm

# plugins names are a refernce to "The good, the bad and the ugly"
sudo dnf install \
	gstreamer1-plugins-good \
	gstreamer1-plugins-bad-free \
	gstreamer1-plugins-bad-freeworld \
	gstreamer1-plugins-ugly \
	gstreamer1-plugins-ugly-free \
	gstreamer1-plugin-libav
