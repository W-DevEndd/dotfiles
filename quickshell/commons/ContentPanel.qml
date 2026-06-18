import QtQuick
import "root:/"

Item {
    id: root

    property color bgColor: Catppuccin.surface0
    property int bgRadius: 10
    property color borderColor: "transparent"
    property int borderWidth: 0

    width: 100

    Rectangle {
        id: buttonBg
        anchors.fill: root

        color: root.bgColor
        radius: root.bgRadius

        border {
            color: root.borderColor
            width: root.borderWidth
        }
    }
}
