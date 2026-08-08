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
            visible: SystemMonitorStates.swapPerc >= 5
            value: SystemMonitorStates.swapPerc + "%"
            prefix: ""
            prefixColor: Catppuccin.lavender

            height: root.height
        }
    }
}
