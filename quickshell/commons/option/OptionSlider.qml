import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/"
import "root:/commons"

RowLayout {
    id: root
    // height: 55

    readonly property real sliderPos: control.position
    signal sliderMoved(real newValue)
    // onSliderMoved: console.log(sliderPos)

    property string leftText: ""
    property color leftTextColor: Catppuccin.text
    property string rightText: ""
    property color rightTextColor: Catppuccin.text


    BaseText {
        text: root.leftText
        color: root.leftTextColor
        font.bold: true
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

        onMoved: {root.sliderMoved(control.value)}

        background: Rectangle {
            id: bg
            width: control.width
            height: 34

            radius: 15
            color: Catppuccin.surface0

            clip: true

            Item {
                anchors.left: bg.left
                height: bg.height

                width: control.visualPosition * bg.width
                clip:true

                Rectangle {
                    width: bg.width
                    height: bg.height
                    radius: bg.radius

                    color: Catppuccin.blue
                }
            }
        }
    }

    BaseText {
        text: root.rightText
        color: root.rightTextColor
        font.bold: true
    }
}

