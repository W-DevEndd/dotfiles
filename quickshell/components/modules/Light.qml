import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import "../base/"

Item {
    clip: true
    property var showBri: hoverHandler.hovered
    width: showBri ? childrenRect.width : childrenRect.height
    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    height: childrenRect.height

    property int bri: 0
    onBriChanged: {
        if (!hoverHandler.hovered) {
            showBri = true
            resetBriVisible.restart()
        }
    }
    property var muted: false

    KeyValueFormat {
        leftMargin: 3
        key: ""
        keyColor: Theme.mauve
        value: parent.bri + "%"
    }

    HoverHandler { id: hoverHandler }

    MouseArea {
        width: parent.width
        height: parent.height
        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0 && parent.bri < 100) briUp.running = true
            else if (wheel.angleDelta.y < 0) briDown.running = true
        }
    }

    Process {
        id: briDown
        command: ["brightnessctl", "set", "5%-"]
    }
    Process {
        id: briUp
        command: ["brightnessctl", "set", "+5%"]
    }

    Process {
        id: updateBri
        running: true
        command: ["sh", "-c", "brightnessctl i | grep Current | awk '{print $4}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                var out = this.text.trim()
                bri = Number(out.slice(1, out.length -2))
            }
        }
    }
    Process {
        command: ["udevadm", "monitor", "--udev", "--subsystem-match=backlight"]
        running: true
        stdout: SplitParser {
            onRead: (line) => {
                updateBri.running = true
            }
        }
    }
    Timer {
        id: resetBriVisible
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            showBri = Qt.binding(function () { return hoverHandler.hovered })
        }
    }
}
