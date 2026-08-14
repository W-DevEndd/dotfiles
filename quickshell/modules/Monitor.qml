import QtQuick
import "root:/"
import "root:/commons/"


ContentPanel {
    id: root
    width: r.width + padding * 2
    property int padding: 8

    Row {
        id: r
        x: root.padding
        height: root.height

        spacing: 10

        PrefixText {

            value: {
                var total = SystemMonitorStates.netDownPerS + SystemMonitorStates.netUpPerS

                if (total < 1024) return total + " B/s"
                else if (total < 1024 * 1024) return (total / 1024).toFixed(1) + " KB/s"
                else return (total / (1024 * 1024)).toFixed(1) + " MB/s"
            }

            prefix: "󰯎"
            prefixColor: Catppuccin.peach

            height: root.height
        }
        PrefixText {
            value: SystemMonitorStates.cpuPerc + "%"
            prefix: ""
            prefixColor: Catppuccin.blue

            height: root.height
        }
        PrefixText {
            value: SystemMonitorStates.memPerc + "%"
            prefix: ""
            prefixColor: Catppuccin.green

            height: root.height
        }
        PrefixText {
            visible: SystemMonitorStates.swapPerc >= 10
            value: SystemMonitorStates.swapPerc + "%"
            prefix: ""
            prefixColor: Catppuccin.lavender

            height: root.height
        }
    }

    MouseArea {
        anchors.fill: root
        cursorShape: Qt.PointingHandCursor
        onClicked: PpStates.showSystemMonitor = !PpStates.showSystemMonitor
    }
}
