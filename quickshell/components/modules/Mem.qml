import QtQuick
import Quickshell.Io
import "../base/"

KeyValueFormat {
    key: ""
    keyColor: Theme.green
    value: "0%"

    Process {
        running: true
        id: cpuProcesss
        command: [
            "sh", "-c", '(free | grep "Mem:" | awk \'{print $2 " " $3}\')'
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                var a = this.text.split(" ")
                value = (Math.round((a[1] / a[0]) * 100)) + "%"
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
