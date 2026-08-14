import QtQuick
import "root:/"

Rectangle {
    id: root

    width: r.width + padding * 2
    height: 256

    color: Catppuccin.base
    border {
        width: 1
        color: Catppuccin.crust
    }

    MouseArea { anchors.fill: root }

    property int padding: 8

    Row {
        id: r
        x: root.padding
        y: root.padding
        height: root.height - root.padding * 2

        spacing: 8
        
        Item {
            id: leftPanel
            height: r.height
            width: height
        }
        Rectangle {
            id: rightPanel
            height: r.height
            width: height * 1.7
        }
    }
}
