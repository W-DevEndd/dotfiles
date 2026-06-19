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
        height: 100

        // snapMode: Slider.SnapAlways
        // stepSize: 10
        from: 0
        to: 100
    }
}

