import QtQuick
import "root:/"
import "root:/utils/"
import "root:/views/system_monitor/"

Rectangle {
    id: root

    width: r.width + padding * 2
    height: 256

    color: Catppuccin.base
    border {
        width: 1
        color: Catppuccin.crust
    }

    MouseArea { anchors.fill: root }

    property int padding: 8

    Row {
        id: r
        x: root.padding
        y: root.padding
        height: root.height - root.padding * 2

        spacing: 8
        
        Rectangle {
            id: leftPanel
            height: r.height
            width: height
        }
        Column {
            id: rightPanel
            height: r.height
            width: height * 1.5

            ProgressBar {
                width: rightPanel.width

                prefix: ""
                displayValue: StrConverter.byteToH(curr) + " / " + StrConverter.byteToH(to)
                barColor: Catppuccin.green
                curr: SystemMonitorStates.usedMem
                from: 0
                to: SystemMonitorStates.totalMem
            }
            ProgressBar {
                width: rightPanel.width

                prefix: ""
                displayValue: StrConverter.byteToH(curr) + " / " + StrConverter.byteToH(to)
                barColor: Catppuccin.lavender
                curr: SystemMonitorStates.usedSwap
                from: 0
                to: SystemMonitorStates.totalSwap
            }
        }
    }
}
