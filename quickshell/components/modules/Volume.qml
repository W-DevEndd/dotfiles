import QtQuick
import Quickshell.Io
import "../base/"

KeyValueFormat {
    property int vol: 0
    key: ""
    keyColor: Theme.mauve
    value: vol + "%"

    Process {
        running: true
        id: cpuProcesss
        command: [
            "sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}'"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                vol = Number(this.text)
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: cpuProcesss.running = true
    }
}
