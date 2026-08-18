import QtQuick
import "root:/"


Rectangle {
    id: root
    property var displayPoints: 10
    property var min: -25000000
    property var max: 100000000
    property var lines: [
        {
            color: Catppuccin.red,
            points: SystemMonitorStates.netUpHistory,
        },
        {
            color: Catppuccin.yellow,
            points: SystemMonitorStates.netDownHistory,
        }
    ]
    border {
        width: 2
        color: Catppuccin.crust
    }
    color: Catppuccin.mantle
    property int padding: 5

    Repeater {
        model: root.lines
        delegate: Canvas {
            id: cv
            Connections {
                target: modelData.points
                function onRowsInserted() {
                    cv.requestPaint()
                }
                function onRowsRemoved() {
                    cv.requestPaint()
                }
            }
            height: root.height - padding * 2
            width: (root.width / root.displayPoints) * Math.min(modelData.points.count, root.displayPoints) - padding * 2
            anchors {
                verticalCenter: root.verticalCenter
                right: root.right
                rightMargin: root.padding
            }
            // Rectangle {
            //     anchors.fill: parent
            // }
            // Component.onCompleted: console.log(JSON.stringify(modelData.points.get(0).value, null, 2))

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, cv.width, cv.height)
                ctx.strokeStyle = modelData.color
                ctx.lineWidth = 2

                ctx.beginPath()

                let totalPoints = modelData.points.count; 
                let startIdx = totalPoints - root.displayPoints;

                ctx.moveTo(
                    (cv.width / (root.displayPoints - 1)) * (0 - startIdx),
                    cv.height - (cv.height / (root.max - root.min)) * (modelData.points.get(0).value - root.min)
                )
                
                for (let i = startIdx; i < totalPoints; i++) {
                    if (i < 1) continue
                    ctx.lineTo(
                        (cv.width / (root.displayPoints - 1)) * (i - startIdx),
                        cv.height - (cv.height / (root.max - root.min)) * (modelData.points.get(i).value - root.min)
                    )
                }

                ctx.stroke()
            }
        }
    }
}
