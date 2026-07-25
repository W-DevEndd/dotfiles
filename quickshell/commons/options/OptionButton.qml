import QtQuick
import QtQuick.Controls
import "root:/"
import "root:/commons/"

Button {
    id: root

    property string displayIcon: "$"

    property color contentColor: Catppuccin.text
    property color bgColor: Catppuccin.blue

    property int radius: 10

    background: Rectangle {
        radius: root.radius
        color: root.bgColor

        BaseText {
            text: root.displayIcon
            color: root.contentColor
            anchors.centerIn: parent
            font.bold: true
            font.pointSize: root.height * 0.6 || 11
        }
    }
}
