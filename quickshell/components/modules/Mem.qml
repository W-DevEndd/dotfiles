import QtQuick
import Quickshell.Io
import "../base/"

KeyValueFormat {
    key: ""
    keyColor: Theme.blue
    value: "0%"

    Process {
        running: true
        id: cpuProcesss
        command: [
            "sh", "-c", '(lscpu | grep "CPU(s):" -m 1 | awk \'{print $2}\');
            (ps aux | sed \'1d\' | awk \'{print $3}\')'
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text.split("\n")
                var core = Number(lines[0])
                var usage = 0
                lines.slice(1).map(item => {
                    usage += Number(item)
                })
                value = Math.round(usage / core) + "%"
            }
        }
    }

    // Timer {
    //     interval: 1000
    //     running: true
    //     repeat: true
    //     onTriggered: cpuProcesss.running = true
    // }
}
