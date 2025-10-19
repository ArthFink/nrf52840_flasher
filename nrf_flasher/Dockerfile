# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Basics + Python + USB utils
RUN apk add --no-cache bash curl jq udev usbutils coreutils python3 py3-pip

# Create a venv and install nrfutil there (avoids PEP 668 error)
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --no-cache-dir nrfutil==7.* intelhex

# Make venv tools available
ENV PATH="/opt/venv/bin:${PATH}"

# Add service + scripts
COPY rootfs/ /

# Ensure executables
RUN chmod +x \
      /etc/cont-init.d/10-prepare.sh \
      /etc/services.d/flasher/run \
      /etc/services.d/flasher/finish \
      /usr/bin/flash_nrfutil.sh \
      /usr/bin/pick_asset.sh
