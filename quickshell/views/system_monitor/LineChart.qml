import QtQuick
import "root:/"


Rectangle {
    id: root
    property var displayPoints: 15
    property var min: 0
    property var max: 100
    property var lines: [
        {
            color: Catppuccin.red,
            points: [5, 3, 40, 53, 2, 49, 42, 9, 70, 43, 50, 97, 4],
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
            height: root.height - padding * 2
            width: (root.width / root.displayPoints) * Math.min(modelData.points.length, root.displayPoints) - padding * 2
            anchors {
                verticalCenter: root.verticalCenter
                right: root.right
                rightMargin: root.padding
            }
            // Rectangle {
            //     anchors.fill: parent
            // }
            // Component.onCompleted: console.log(JSON.stringify(modelData, null, 2))

            onPaint: {
                var ctx = getContext("2d")
                ctx.strokeStyle = modelData.color
                ctx.lineWidth = 2

                ctx.beginPath()

                let totalPoints = modelData.points.length; 
                let startIdx = totalPoints - root.displayPoints;

                ctx.moveTo(
                    (cv.width / (root.displayPoints - 1)) * (0 - startIdx),
                    cv.height - (cv.height / (root.max - root.min)) * (modelData.points[0] - root.min)
                )
                
                for (let i = startIdx; i < totalPoints; i++) {
                    if (i < 1) continue
                    ctx.lineTo(
                        (cv.width / (root.displayPoints - 1)) * (i - startIdx),
                        cv.height - (cv.height / (root.max - root.min)) * (modelData.points[i] - root.min)
                    )
                }

                ctx.stroke()
            }
        }
    }
}
