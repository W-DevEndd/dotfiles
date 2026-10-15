#!/usr/bin/env bash

export XCURSOR_SIZE=32
export $(dbus-launch)

MESA_NO_ERROR=1 GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy virgl_test_server --use-egl-surfaceless --use-gles &

i3
