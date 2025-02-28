FROM alpine:3.16
LABEL maintainer="Ben V. Brown <ralim@ralimtek.com>"

WORKDIR /build
# Installing the two compilers, python3, python3 pip, clang format
# Compilders ->gcc-* newlib-*
# Python3 -> py*
# Misc -> findutils make git
# musl-dev is required for the multi lang firmwares
# clang is required for clang-format (for dev)
ENV APK_COMPS="gcc-riscv-none-elf gcc-arm-none-eabi newlib-riscv-none-elf \
               newlib-arm-none-eabi"
ENV APK_PYTHON="python3 py3-pip"
ENV APK_MISC="findutils make git"
ENV APK_DEV="musl-dev clang bash clang-extra-tools"

# Python3 packages
ENV PIP_PKGS='bdflib black'

RUN apk add --no-cache ${APK_COMPS} ${APK_PYTHON} ${APK_MISC} ${APK_DEV}

# Install Python3 packages

RUN python3 -m pip install ${PIP_PKGS}
# Git trust
RUN git config --global --add safe.directory /build/source

COPY . /build/source
COPY ./ci /build/ci
