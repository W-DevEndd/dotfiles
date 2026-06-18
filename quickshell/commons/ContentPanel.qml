import QtQuick
import "root:/"

Item {
    id: root

    property color bgColor: Catppuccin.surface0
    property int bgRadius: 10

    width: 100

    Rectangle {
        id: buttonBg
        anchors.fill: root

        color: root.bgColor
        radius: root.bgRadius
    }
}
