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

    property string leftTextSample: "100"
    property string leftText: ""
    property color leftTextColor: Catppuccin.text
    property var handleLeftTextClick: () => {}

    property string rightTextSample: ""
    property string rightText: ""
    property color rightTextColor: Catppuccin.text
    property var handleRightTextClick: () => {}


    height: 34

    Item {
        width: frameLeft.width
        height: root.height
        anchors {
            left: root.left
            leftMargin: root.padding
        }
        Label {
            id: frameLeft
            color: "transparent"
            text: root.leftTextSample
        }
        BaseText {
            text: root.leftText
            color: root.leftTextColor
            anchors.centerIn: parent
            font.bold: true
        }
        MouseArea {
            anchors.fill: parent
            onClicked: root.handleLeftTextClick()
        }
    }

    Slider {
        id: control
        handle: null

        // property var isUpdating: false

        snapMode: Slider.SnapOnRelease
        stepSize: 0.01
        from: 0
        to: 1

        height: bg.height
        width: root.width - 2 * (root.labelPanelSize + root.spacing + root.padding)

        anchors.centerIn: root

        Binding on value {
            value: root.newValue
        }
        onMoved: {
            // isUpdating = true
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
        width: frameRight.width
        anchors {
            right: root.right
            verticalCenter: root.verticalCenter
            rightMargin: root.padding
        }
        Label {
            id: frameRight
            color: "transparent"
            text: root.rightTextSample
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

