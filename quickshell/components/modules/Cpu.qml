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
            "sh", "-c", "top -bn1 | grep '%Cpu(s):' | awk '{print $8}'"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                var ide = Math.round(Number(this.text))
                format.value = 100 - ide + "%"
            }
        }
    }
    Process {
        id: cpuTemp
        running: true
        command: ["sh", "-c", "cat /sys/class/thermal/thermal_zone*/temp"]
        stdout: StdioCollector {
            onStreamFinished: {
                var out = Number(this.text)
                format.extraValue = out / 1000 + "󰔄"
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            cpuProcesss.running = true
            cpuTemp.running = format.useExtraValue
        }
    }
}
