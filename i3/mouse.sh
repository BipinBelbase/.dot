#!/bin/bash

# Automatically find the right DISPLAY
export DISPLAY=$(who | grep '(:' | awk '{print $NF}' | tr -d '()')
export XAUTHORITY=/home/$(whoami)/.Xauthority

sleep 2

DEVICE_NAME="Mosart 2.4G MOUSE Mouse"
DEVICE_ID=$(xinput list --id-only "$DEVICE_NAME")

if [ -z "$DEVICE_ID" ]; then
  echo "$(date): Device not found: $DEVICE_NAME" >>/tmp/mouse-fix.log
else
  echo "$(date): Found $DEVICE_NAME with ID: $DEVICE_ID" >>/tmp/mouse-fix.log
  xinput set-prop "$DEVICE_ID" "Coordinate Transformation Matrix" 0.25 0 0 0 0.25 0 0 0 1
  echo "$(date): Sensitivity set!" >>/tmp/mouse-fix.log
fi
