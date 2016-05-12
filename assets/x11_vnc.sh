#!/bin/bash

/usr/bin/Xvfb :0 -screen 0 1366x768x16 &

x11vnc -forever -usepw -create

#java -Xmx500M -cp "/data/coma/lib/coma-gui.jar:/data/coma/lib/coma-engine.jar:/data/coma/lib/additional/*:/data/coma/lib/maven/*:/data/coma/lib/additional/*:" de.wdilab.coma.gui.Main