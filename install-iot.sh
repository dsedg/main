#!/usr/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# mitigate upstream packaging bug: https://bugzilla.redhat.com/show_bug.cgi?id=2332429
# swap the incorrectly installed OpenCL-ICD-Loader for ocl-icd, the expected package
rpm-ostree override replace \
  --from repo='fedora' \
  --experimental \
  --remove=OpenCL-ICD-Loader \
  ocl-icd \
  || true



    rpm-ostree override replace \
        --experimental \
        --install=zstd \
        kernel \
        kernel-rpi4
        
CSFG=/usr/lib/systemd/system-generators/coreos-sulogin-force-generator
curl -sSLo ${CSFG} https://raw.githubusercontent.com/coreos/fedora-coreos-config/refs/heads/stable/overlay.d/05core/usr/lib/systemd/system-generators/coreos-sulogin-force-generator
chmod +x ${CSFG}

 /ctx/initramfs.sh
