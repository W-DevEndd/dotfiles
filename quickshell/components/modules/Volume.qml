import QtQuick
import Quickshell
import Quickshell.Io
import "../base/"

Item {
    clip: true
    width: hoverHandler.hovered ? childrenRect.width : childrenRect.height
    Behavior on width { NumberAnimation { duration: 100; easing.type: Easing.InQuad } }
    height: childrenRect.height

    property int vol: 0

    KeyValueFormat {
        key: parent.vol >= 50 ? "" :
            parent.vol >= 20 ? " " :
            " "
        keyColor: Theme.mauve
        value: parent.vol + "%"
    }

    HoverHandler { id: hoverHandler }

    MouseArea {
        width: parent.width
        height: parent.height
        onClicked: openPavuctl.running = true
        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) volUp.running = true
            else volDown.running = true
        }
    }

    Process {
        id: updateVol
        running: true
        command: [
            "sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}'"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                vol = Number(this.text)
            }
        }
    }

    Process {
        id: openPavuctl
        command: ["pavucontrol"]
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

    Process {
        id: volDown
        command: ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%"]
    }
    Process {
        id: volUp
        command: ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%"]
    }
}
