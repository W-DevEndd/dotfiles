import QtQuick
import QtQuick.Controls
import "root:/"













Button {
    id: root
    property var toggleState: false

    property string displayIcon: "$"

    background: Rectangle {
        radius: 5
        color: root.toggleState ? Catppuccin.blue : Catppuccin.surface2

        Label {
            text: root.displayIcon
            color: root.toggleState ? Catppuccin.crust : Catppuccin.subtext1
            anchors.centerIn: parent
            font.bold: true
            font.pointSize: root.height * 0.3
        }
    }

    onClicked: toggleState = !toggleState
}
