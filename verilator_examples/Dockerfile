# Use the latest Fedora base image
FROM fedora:latest

# Update system and install dependencies
RUN dnf -y update && \
    dnf -y install \
	xeyes \
        git \
        make \
        autoconf \
        gcc \
        gcc-c++ \
        vim \
        verilator \
	gtkwave \
        && dnf clean all

ENV DISPLAY=host.docker.internal:0.0

# Verify installation
RUN verilator --version && g++ --version

# Default working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
