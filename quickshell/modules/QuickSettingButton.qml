import QtQuick
import "root:/"
import "root:/commons/"

ContentPanel {
    id: root

    width: height

    bgColor: hoverHandler.hovered ? Catppuccin.surface0 : Catppuccin.base

    BaseText {
        anchors.centerIn: root
        text: ""
    }

    MouseArea {
        anchors.fill: root
        onClicked: PpStates.showQuickSettings = !PpStates.showQuickSettings

        HoverHandler {
            id: hoverHandler
            enabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }
}
