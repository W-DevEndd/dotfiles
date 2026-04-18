import QtQuick
import Quickshell.Io
import "../base/"

Item {
    width: format.width
    height: format.height

    KeyValueFormat {
        id: format
        key: ""
        keyColor: Theme.green
        value: "0%"
        extraValue: "aaaaaaaaaaaa"
    }
    MouseArea {
        height: parent.height
        width: parent.width
        onClicked: format.useExtraValue = !format.useExtraValue
    }
    Process {
        running: true
        id: cpuProcesss
        command: [
            "sh", "-c", '(free | grep "Mem:" | awk \'{print $2 " " $3}\')'
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                var out = this.text.split(" ")
                var total = Number(out[0])
                var usage = Number(out[1])
                format.value = (Math.round(usage / total * 100)) + "%"
                format.extraValue = (usage / 1000000).toFixed(2) + " GiB / " + (total / 1000000).toFixed(2) + " GiB"
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
