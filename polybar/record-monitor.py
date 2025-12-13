import os, sys
from pathlib import Path

videoDir = Path(sys.argv[1]).expanduser()
pidFile = videoDir / ".recording"
pid = None
icon = "󰻂 "

if os.path.exists(pidFile):
    icon = " "
    with open(pidFile, "r") as f:
        data = f.read().strip()
        if data == "writing...": icon = " "
        elif data == "washing...": icon = " "
print(icon)
