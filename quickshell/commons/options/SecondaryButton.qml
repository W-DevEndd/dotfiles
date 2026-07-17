import QtQuick
import QtQuick.Controls
import "root:/"
import "root:/commons/"

Button {
    id: root

    property string displayIcon: "$"
    background: Rectangle {
        color: root.hovered ? Catppuccin.surface1 : Catppuccin.surface0
        radius: 5

        BaseText {
            text: root.displayIcon
            anchors.centerIn: parent
            font.bold: true
        }
    }
}
