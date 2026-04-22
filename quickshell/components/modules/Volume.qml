import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import "../base/"

Item {
    clip: true
    property var showVol: hoverHandler.hovered
    width: mainContent.width
    height: mainContent.height

    property int vol: 0
    onVolChanged: {
        if (!hoverHandler.hovered) {
            showVol = true
            resetVolVisible.restart()
        }
    }
    property var muted: false

    KeyValueFormat {
        id: mainContent
        key: muted ? "" :
            parent.vol >= 50 ? "" :
            parent.vol >= 10 ? "" :
            " "
        keyColor: Theme.mauve
        showValue: parent.showVol
        value: parent.vol + "%"
    }

    HoverHandler { id: hoverHandler }

    MouseArea {
        width: parent.width
        height: parent.height
        onClicked: muteToggle.running = true
        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0 && parent.vol < 100) volUp.running = true
            else if (wheel.angleDelta.y < 0) volDown.running = true
        }
    }

    Process {
        id: openPavuctl
        command: ["pavucontrol"]
    }
    Process {
        id: muteToggle
        command: ["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"]
    }
    Process {
        id: volDown
        command: ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%"]
    }
    Process {
        id: volUp
        command: ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%"]
    }

    Process {
        id: updateVol
        running: true
        command: [
            "wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                var out = this.text.trim().split(/\s+/)

                vol = Number(Number(out[1]) * 100)
                muted = out.includes("[MUTED]")
            }
        }
    }
    Process {
        command: ["pactl", "subscribe"]
        running: true
        stdout: SplitParser {
            onRead: (line) => {
                if (line.includes("change")) {
                    updateVol.running = true
                }
            }
        }
    }
    Timer {
        id: resetVolVisible
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            showVol = Qt.binding(function () { return hoverHandler.hovered })
        }
    }
}
