FROM alpine:latest
#
# BUILD:
#   wget https://raw.githubusercontent.com/thbe/docker-cups/master/Dockerfile
#   docker build --rm --no-cache -t thbe/cups .
#
# USAGE:
#   wget https://raw.githubusercontent.com/thbe/docker-cups/master/start_cups.sh
#   ./start_cups.sh
#

# Set metadata
LABEL author="thbe - https://github.com/thbe"
LABEL maintainer="jelliuk - https://github.com/jelliuk"
LABEL version="2.0"
LABEL description="Creates an Alpine container serving a CUPS instance accessible through airplay as well"

# Set environment
ENV LANG en_US.UTF-8
ENV TERM xterm

# Set workdir
WORKDIR /opt/cups

# Install CUPS/AVAHI
RUN apk update --no-cache && apk add --no-cache cups cups-filters avahi inotify-tools

# Install Splix Drivers for Samsung Printers
RUN apk add --no-cache splix --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing

# Copy configuration files
COPY root /

# Prepare CUPS container
RUN chmod 755 /srv/run.sh

# Expose SMB printer sharing
EXPOSE 137/udp 139/tcp 445/tcp

# Expose IPP printer sharing
EXPOSE 631/tcp

# Expose avahi advertisement
EXPOSE 5353/udp

# Start CUPS instance
CMD ["/srv/run.sh"]
