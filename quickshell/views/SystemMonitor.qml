import QtQuick
import "root:/"
import "root:/commons/"
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
            width: height * 2

            Column {
                id: barPanel
                width: parent.width

                ProgressBar {
                    width: rightPanel.width

                    prefix: ""
                    displayValue: StrConverter.byteToH(curr, 2) + " / " + StrConverter.byteToH(to, 2)
                    barColor: Catppuccin.green
                    curr: SystemMonitorStates.usedMem
                    from: 0
                    to: SystemMonitorStates.totalMem
                }
                ProgressBar {
                    width: rightPanel.width

                    prefix: ""
                    displayValue: StrConverter.byteToH(curr, 2) + " / " + StrConverter.byteToH(to, 2)
                    barColor: Catppuccin.lavender
                    curr: SystemMonitorStates.usedSwap
                    from: 0
                    to: SystemMonitorStates.totalSwap
                }
                // Repeater {
                //     model: SystemMonitorStates.mounts
                //     delegate: ProgressBar {
                //         width: rightPanel.width
                //
                //         prefix: " (" + modelData.name +")"
                //         displayValue: StrConverter.byteToH(curr) + " / " + StrConverter.byteToH(to)
                //         barColor: Catppuccin.mauve
                //         curr: modelData.used
                //         from: 0
                //         to: modelData.total
                //     }
                // }
            }

            Row {
                id: chartPanel
                width: parent.width
                height: parent.height - barPanel.height

                spacing: 8

                LineChart {
                    id: netLineChart
                    height: chartPanel.height
                    width: chartPanel.width * 0.75
                }
                Column {
                    id: netTextPanel
                    width: parent.width - parent.spacing - netLineChart.width
                    height: childrenRect.height
                    anchors.bottom: parent.bottom

                    AnchoredPrefixText {
                        width: parent.width

                        prefix: ""
                        value: StrConverter.byteToH(SystemMonitorStates.netUpPerS) + "/s"
                        prefixColor: Catppuccin.red
                    }
                    AnchoredPrefixText {
                        width: parent.width

                        prefix: ""
                        value: StrConverter.byteToH(SystemMonitorStates.netDownPerS) + "/s"
                        prefixColor: Catppuccin.yellow
                    }
                }
            }
        }
    }
}
