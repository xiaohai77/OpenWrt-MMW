#!/bin/bash

declare -A GO_TARGETS=(
  [arm64]="linux,arm64,-,-"
  [armv7]="linux,arm,7,-"
  [armv6]="linux,arm,6,-"
  [armv5]="linux,arm,5,-"
  [riscv64]="linux,riscv64,-,-"
  [x86]="linux,386,-,softfloat"
  [amd64]="linux,amd64,-,-"
)

declare -A OPKG_ARCHES=(
  [arm64]="aarch64_cortex-a53 aarch64_cortex-a72 aarch64_generic"
  [armv7]="arm_cortex-a7 arm_cortex-a7_neon-vfpv4 arm_cortex-a9 arm_cortex-a9_neon arm_cortex-a15_neon-vfpv4"
  [armv6]="arm_arm1176jzf-s_vfp arm_fa526"
  [armv5]="arm_mpcore arm_xscale"
  [riscv64]="riscv64_generic riscv64"
  [x86]="i386_pentium4 i386_pentium-mmx i386_geode"
  [amd64]="x86_64"
)
