# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Basics + Python + USB utils + build deps for wheels
RUN apk add --no-cache \
      bash curl jq udev usbutils coreutils python3 py3-pip \
      build-base libffi-dev openssl-dev

# venv + legacy nrfutil (has 'dfu usb-serial')
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --no-cache-dir nrfutil==5.2.0 intelhex

# expose venv tools
ENV PATH="/opt/venv/bin:${PATH}"

# (optional) fail fast if dfu is missing
RUN nrfutil --help | head -n 5 && nrfutil dfu --help | head -n 5

# add service + scripts
COPY rootfs/ /

# ensure executables
RUN chmod +x \
      /etc/cont-init.d/10-prepare.sh \
      /etc/services.d/flasher/run \
      /etc/services.d/flasher/finish \
      /usr/bin/flash_nrfutil.sh \
      /usr/bin/pick_asset.sh
