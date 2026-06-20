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
        text: Math.floor(slider.position * 100)
    }

    Slider {
        id: slider
        Layout.fillWidth: true
        handle: null

        height: bg.height

        background: Rectangle {
            id: bg
            width:slider.width
            height: 34

            radius: 10
            color: Catppuccin.crust
        }

        // snapMode: Slider.SnapAlways
        // stepSize: 10
        from: 0
        to: 100
    }
}

