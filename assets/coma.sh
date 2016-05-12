#!/bin/bash

cd /data/coma
java -Xmx500M -cp "/data/coma/lib/coma-gui.jar:/data/coma/lib/coma-engine.jar:/data/coma/lib/additional/*:/data/coma/lib/maven/*:/data/coma/lib/additional/*:" de.wdilab.coma.gui.Main