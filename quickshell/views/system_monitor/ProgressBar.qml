import QtQuick
import "root:/"
import "root:/commons/"

Item {
    id: root

    property string prefix: "$"
    property string displayValue: curr + " / " + to
    property color barColor: Catppuccin.red
    property var curr: 35
    property var from: 0
    property var to: 100
    height: 34

    property int spacing: 8

    BaseText {
        id: pfx
        text: root.prefix
        anchors {
            left: root.left
            verticalCenter: root.verticalCenter
        }
    }
    BaseText {
        id: val
        text: root.displayValue
        anchors {
            right: root.right
            verticalCenter: root.verticalCenter
        }
    }
    Rectangle {
        x: root.spacing + pfx.width
        anchors.verticalCenter: root.verticalCenter
        height: pfx.height * 1
        width: root.width - x - root.spacing - val.width
        radius: height / 2
        color: Catppuccin.crust

        Rectangle {
            anchors.left: parent.left
            height: parent.height
            width: Math.max(height, parent.width * (root.curr / (root.to - root.from)))
            radius: height / 2
            color: root.barColor
        }
    }
}
