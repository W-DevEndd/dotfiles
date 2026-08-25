import QtQuick
import QtQuick.Shapes
import "root:/"
import "root:/commons/"

Item {
    id: root
    property int barWidth: 24
    property int primaryTextSize: 24
    property int secondaryTextW: Math.max(secondaryText.width, 64)

    property var from: 0
    property var to: 100
    property var value: 36
    property string displayValue: value + "GHz"
    property string secondaryValue: "369"

    BaseText {
        id: primaryText
        text: root.displayValue
        font {
            bold: true
            pointSize: root.primaryTextSize
        }
        anchors.centerIn: parent
    }
    BaseText {
        id: secondaryText
        text: root.secondaryValue
        font.bold: true
        anchors {
            horizontalCenter: root.horizontalCenter
            bottom: root.bottom
        }
    }
    Shape {
        anchors.fill: root
        layer.enabled: true
        layer.samples: 4

        ShapePath {
            fillColor: "transparent"
            strokeColor: Catppuccin.crust
            strokeWidth: root.barWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width - root.barWidth) / 2
                radiusY: (root.height - root.barWidth) / 2
                startAngle: 90 + root.secondaryTextW / 2
                sweepAngle: 360 - root.secondaryTextW
            }
        }
    }

    Shape {
        anchors.fill: root
        layer.enabled: true
        layer.samples: 4

        ShapePath {
            fillColor: "transparent"
            strokeColor: Catppuccin.blue
            strokeWidth: root.barWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width - root.barWidth) / 2
                radiusY: (root.height - root.barWidth) / 2
                startAngle: 90 + root.secondaryTextW / 2
                sweepAngle: (360 - root.secondaryTextW) * (( root.value - root.from) / (root.to - root.from))
            }
        }
    }

}
