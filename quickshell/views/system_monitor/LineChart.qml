import QtQuick
import "root:/"

Rectangle {
    id: root
    property var displayPoints: 50
    property var min: 0
    property var max: 100
    property var lines: [
        {
            color: Catppuccin.red,
            points: [5, 3, 40, 53, 2, 49, 42],
        }
    ]
    border {
        width: 2
        color: Catppuccin.crust
    }
    color: Catppuccin.mantle

    Repeater {
        model: root.lines
        delegate: Canvas {
            id: cv
            height: root.height
            width: root.width / root.displayPoints * modelData.points.length
            // Component.onCompleted: console.log(JSON.stringify(modelData, null, 2))

            onPaint: {
                var ctx = getContext("2d")
                ctx.strokeStyle = modelData.color
                ctx.lineWidth = 2

                ctx.beginPath()
                ctx.moveTo()
            }
        }
    }
}
