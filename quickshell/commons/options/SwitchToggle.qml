import QtQuick
import QtQuick.Controls
import "root:/"

Switch {
    id: root

    width: 2 * height

    contentItem: Item {}
    
    indicator: Rectangle {
        height:   parent.height
        width: (2 / 3) * parent.width
        x: root.visualPosition * (1 / 3) * parent.width
        Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutBack }}
        radius: 5
        border {
            color: Catppuccin.overlay0
            width: 1
        }
    }
    background: Rectangle {
        height: root.height
        width: root.width

        radius: 5
        color: Catppuccin.surface2
        Item {
            height: parent.height
            width: ((2 / 3) * parent.width) / 2 + root.visualPosition * (1 / 3) * parent.width
            Behavior on width { NumberAnimation { duration: 400; easing.type: Easing.OutBack }}
            clip: true

            Rectangle {
                anchors.left: parent.left
                height: parent.height
                width: parent.parent.width

                color: Catppuccin.blue
                radius: 5
            }
        }
    }
}
