#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -Sy --noconfirm --needed \
	scons \
	pkgconf \
	gcc \
	libxcursor \
	libxinerama \
	libxi \
	libxrandr \
	wayland-utils \
	mesa \
	glu \
	libglvnd \
	alsa-lib \
	clang \
	mold
# pulseaudio (didnt work on my pc, cuz I had pulse wire I think but it worked without)

run_on_fedora warn "Fedora godot is not yet tested."
run_on_fedora sudo dnf install -y \
	scons \
	pkgconfig \
	gcc-c++ \
	libstdc++-static \
	clang \
	mold \
	wayland-devel

scons platform=linuxbsd target=editor debug_symbols=yes optimize=debug use_llvm=yes linker=mold module_mono_enabled=yes

# se_llvm=yes linker=lld
# just to use clang, which is faster (disable for production builds tho)

# NOTE: the values i specified are the ones used when running scons without args. (including the architecture below)
# architecture x86_64

# multi-threading: 19 threads. My pc has 20 available -j19
# it uses by default all - 1 on hardware which have 4+

# debug_symbols are not included by default because they are large.
# but good to have, for getting stack traces when the editor crashes.

# optimize=speed: Favors even more execution speed, at the cost of even larger binary size compared to optimize=speed_trace. Even less friendly to debugging compared to optimize=debug, as this uses the most aggressive optimizations available.
# optimize=size (default when targeting the Web platform): Favors small binaries at the cost of slower execution speed.
# optimize=size_extra: Favors even smaller binaries, at the cost of even slower execution speed compared to optimize=size.
# optimize=debug: Only enables optimizations that do not impact debugging in any way. This results in faster binaries than optimize=none, but slower binaries than optimize=speed_trace.
