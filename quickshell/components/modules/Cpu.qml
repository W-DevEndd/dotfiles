import QtQuick
import Quickshell.Io
import "../base/"

KeyValueFormat {
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
                    usage += Math.round(Number(item))
                })
                console.log(Math.round(usage / core))
            }
        }
    }
    key: ""
    keyColor: Theme.blue
    value: "0%"
}
