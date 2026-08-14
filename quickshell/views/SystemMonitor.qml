import QtQuick
import "root:/"

Rectangle {
    id: root
    width: 740
    height: 256

    color: Catppuccin.base
    border {
        width: 1
        color: Catppuccin.crust
    }

    MouseArea { anchors.fill: root }
}
