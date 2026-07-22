import QtQuick
import QtQuick.Controls
import "root:/"

Button {
    id: root

    property string displayIcon: "#"
    property color iconColor: Catppuccin.text
    property color bgColor: Catppuccin.surface0

    background: Rectangle {
        color: root.bgColor
        radius: 5

        Text {
            text: root.displayIcon
            anchors.centerIn: parent
            color: root.iconColor
        }
    }
}
