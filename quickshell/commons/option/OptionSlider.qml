import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/"
import "root:/commons"

RowLayout {
    id: root
    // height: 55

    BaseText {
        text: Math.floor(control.position * 100)
    }

    Slider {
        id: control
        Layout.fillWidth: true
        handle: null

        // snapMode: Slider.SnapAlways
        // stepSize: 10
        from: 0
        to: 1

        height: bg.height

        background: Rectangle {
            id: bg
            width: control.width
            height: 34

            radius: 15
            color: Catppuccin.surface0

            clip: true

            Rectangle {
                anchors.left: bg.left
                height: bg.height

                // radius: 10
                color: Catppuccin.blue

                width: control.visualPosition * bg.width
            }
        }
    }
}

