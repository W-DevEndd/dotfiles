import QtQuick
import "root:/"

Item {
    id: root

    property color bgColor: Catppuccin.base
    property int bgRadius: 10
    property color borderColor: Catppuccin.crust
    property int borderWidth: 2

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
