import QtQuick
import Quickshell
import Quickshell.Io
import "../base/"

Item {
    clip: true
    width: hoverHandler.hovered ? childrenRect.width : childrenRect.height
    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    height: childrenRect.height

    property int vol: 0
    property var muted: false

    KeyValueFormat {
        key: muted ? "" :
            parent.vol >= 50 ? "" :
            parent.vol >= 10 ? " " :
            " "
        keyColor: Theme.mauve
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
                if (line.includes("change")) updateVol.running = true
            }
        }
    }
}
