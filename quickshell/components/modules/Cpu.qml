import QtQuick
import Quickshell.Io
import "../base/"

Item {
    width: format.width
    height: format.height

    KeyValueFormat {
        id: format
        key: ""
        keyColor: Theme.blue
        value: "0%"

        useExtraValue: false
        extraValue: "aaaaa"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: format.useExtraValue = !format.useExtraValue
    }

    Process {
        id: cpuProcesss
        running: true
        command: [
            "sh", "-c", '(lscpu | grep "CPU(s):" -m 1 | awk \'{print $2}\');
            (ps -eo pcpu | sed \'1d\')'
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text.split("\n")
                var core = Number(lines[0])
                var usage = 0
                lines.slice(1).map(item => {
                    usage += Number(item)
                })
                format.value = Math.round(usage / core) + "%"
            }
        }
    }
    Process {
        id: cpuTemp
        running: true
        command: ["sh", "-c", '"cat /sys/class/thermal/thermal_zone*/temp"']
        stdout: StdioCollector {
            onStreamFinished: {
                var out = this.text
                console.log(out)
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            cpuProcesss.running = true
            cpuTemp.running = true
        }
    }
}
