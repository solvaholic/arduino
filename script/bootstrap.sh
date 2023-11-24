#!/bin/bash

# * Create config file, if it doesn't exist
# * TODO: Ensure prerequisites are met
# * Set 'additional_urls'
# * Set 'directories' to use this repository
# * ???

_directories_data="$(git rev-parse --show-toplevel)"
_config_file="$_directories_data/arduino-cli.yaml"
_additional_urls="https://github.com/Heltec-Aaron-Lee/WiFi_Kit_series/releases/download/0.0.9/package_heltec_esp32_index.json"

# Create the configuration file, if it doesn't exist
if [ ! -r "$_config_file" ]; then
  arduino-cli config dump --verbose --no-color \
  | sed -e /^time=/d \
  > "$_config_file"
fi

# TODO: Ensure prerequisites are met:
#   arduino-cli is available; config is valid

# Set 'additional_urls'
arduino-cli config --config-file "$_config_file" \
  set board_manager.additional_urls $_additional_urls

# Set 'directories' to use this repository
arduino-cli config --config-file "$_config_file" \
  set directories.data "$_directories_data"
arduino-cli config --config-file "$_config_file" \
  set directories.downloads "$_directories_data/staging"
arduino-cli config --config-file "$_config_file" \
  set directories.user "$_directories_data"
