import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/"
import "root:/commons"

Item {
    id: root
    // height: 55

    property int labelPanelSize: 0.05 * width
    property int spacing: 10
    property int padding: 5

    readonly property real sliderPos: control.position
    property real newValue: sliderPos
    signal sliderMoved(real newValue)

    // onSliderMoved: console.log(sliderPos)

    property string leftText: ""
    property color leftTextColor: Catppuccin.text
    property var handleLeftTextClick: () => {
        console.log("Aaaaaaa")
    }

    property string rightText: ""
    property color rightTextColor: Catppuccin.text
    property var handleRightTextClick: () => {}


    height: 34

    Item {
        width: root.labelPanelSize
        anchors {
            left: root.left
            verticalCenter: root.verticalCenter
            leftMargin: root.padding
        }
        BaseText {
            text: root.leftText
            color: root.leftTextColor
            anchors.centerIn: parent
            font.bold: true
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("aaaaaa")
            }
        }
    }

    Slider {
        id: control
        handle: null

        // snapMode: Slider.SnapAlways
        // stepSize: 10
        from: 0
        to: 1

        height: bg.height
        width: root.width - 2 * (root.labelPanelSize + root.spacing + root.padding)

        anchors.centerIn: root

        Binding on value {
            value: root.newValue
        }
        onMoved: {
            root.sliderMoved(control.value)
        }

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

    Item {
        width: root.labelPanelSize
        anchors {
            right: root.right
            verticalCenter: root.verticalCenter
            rightMargin: root.padding
        }
        BaseText {
            text: root.rightText
            color: root.rightTextColor
            anchors.centerIn: parent
            font.bold: true
        }
        MouseArea {
            anchors.fill: parent
            onClicked: root.handleRightTextClick()
        }
    }
}

