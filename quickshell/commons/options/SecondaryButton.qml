import QtQuick
import QtQuick.Controls
import "root:/"

Button {
    id: root

    property string displayIcon: "$"
    background: Rectangle {
        color: root.hovered ? Catppuccin.surface1 : Catppuccin.surface0
        radius: 5

        Label {
            text: root.displayIcon
            anchors.centerIn: parent
        }
    }
}
