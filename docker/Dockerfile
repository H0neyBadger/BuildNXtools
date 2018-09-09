FROM base/archlinux:latest

ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITARM=/opt/devkitpro/devkitARM
ENV DEVKITPPC=/opt/devkitpro/devkitPPC


ENV WORKDIR="/build"
# build args 
ARG OWNER_UID
ARG OWNER_GID

WORKDIR "${WORKDIR}"

# BUILD as non-root user
RUN groupadd --gid "${OWNER_GID}" "builder" 
RUN useradd --uid "${OWNER_UID}" \
    --gid "${OWNER_GID}" \
    "builder"

# Upgarde image
RUN pacman --noconfirm -Syu

# Install requirements for libtransistor 
RUN pacman --noconfirm -S \
    llvm \
    clang \
    lld \
    python \
    python-pip \
    python-virtualenv \
    squashfs-tools \
    base-devel \
    git \
    cmake \
    libx11

# Install devkitpro 
# doc source :
# https://devkitpro.org/wiki/devkitPro_pacman

# First import the key which is used to validate the packages 
RUN pacman-key --recv F7FD5492264BB9D0
RUN pacman-key --lsign F7FD5492264BB9D0

# Add the devkitPro repositories
ADD devkit_repo ./devkit_repo
RUN cat ./devkit_repo >> /etc/pacman.conf
# Install the keyring which adds more keys which may be used to verify the packages. 
RUN pacman --noconfirm -U https://downloads.devkitpro.org/devkitpro-keyring-r1.787e015-2-any.pkg.tar.xz
# Now resync the database and update installed packages.
RUN pacman -Sy

RUN pacman --noconfirm -Syu

#RUN pacman --noconfirm -S $(pacman -Slq dkp-libs)

RUN pacman --noconfirm -S \
    switch-dev \
    switch-zlib \
    switch-sdl2 \
    switch-freetype \
    switch-curl \
    sfml \
    devkitARM 

RUN pip3 install -U pip

USER builder

