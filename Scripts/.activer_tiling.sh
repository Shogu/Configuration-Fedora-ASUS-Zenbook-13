#!/bin/bash

EXTENSION_ID="tilingshell@ferrarodomenico.com"

if gnome-extensions list --enabled | grep -q $EXTENSION_ID; then
    gnome-extensions disable $EXTENSION_ID
else
    gnome-extensions enable $EXTENSION_ID
fi

