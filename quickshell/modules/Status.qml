import QtQuick
import "root:/"
import "root:/commons/"

ContentPanel {
    id: root

    width: height

    bgColor: hoverHandler.hovered ? Catppuccin.surface1 : Catppuccin.surface0

    BaseText {
        anchors.centerIn: root
        text: "󰍜"
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
