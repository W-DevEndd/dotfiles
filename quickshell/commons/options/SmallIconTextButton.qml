import QtQuick
import QtQuick.Controls
import "root:/"
import "root:/commons/"

Button {
    id: root

    property string displayIcon: "#"
    property string displayText: "Aaaaaa"

    property color contentColor: Catppuccin.text
    property color bgColor: Catppuccin.surface0
    padding: 5

    width: bg.width

    background: Rectangle {
        id: bg
        radius: 5
        color: root.bgColor
        height: root.height
        width: childrenRect.width + root.padding * 2

        Row {
            anchors.verticalCenter: parent.verticalCenter
            height: childrenRect.height
            width: childrenRect.width
            x: root.padding
            spacing: 5

            BaseText {
                text: root.displayIcon
                color: root.contentColor
            }
            BaseText {
                text: root.displayText
                color: root.contentColor
            }
        }
    }
}
