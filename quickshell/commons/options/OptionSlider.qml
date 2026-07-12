import QtQuick
import QtQuick.Controls
import "root:/"
import "root:/commons"


Item {
    id: root

    // panel
    property string iconSample:  "󱐋"
    property string valueSample: "100"

    // value and icon
    property string displayIcon:  "󱐋"
    property string displayValue: currentValue

    // slider properties
    property real currentValue: control.value
    property real minValue: 0
    property real maxValue: 100
    property real sliderStep: 1
    property var sliderSnap: Slider.SnapOnRelease

    property int horizontalPadding: 5
    property int spacing: 5

    Label {
        id: iconPanel
        text: root.iconSample
        color: "transparent"
        height: root.height
        anchors.left: root.left
        anchors.leftMargin: root.horizontalPadding

        BaseText {
            text: root.displayIcon
            anchors.centerIn: parent
        }
    }
    Label {
        id: valuePanel
        text: root.valueSample
        color: "transparent"
        height: root.height
        anchors.right: root.right
        anchors.rightMargin: root.horizontalPadding

        BaseText {
            text: root.displayValue
            anchors.centerIn: parent
        }
    }

    Slider {
        id: control
        height: root.height
        width: root.width - 2 * (root.spacing + root.horizontalPadding) - iconPanel.width - valuePanel.width
        x: root.horizontalPadding + iconPanel.width + root.spacing

        snapMode: root.sliderSnap
        stepSize: root.sliderStep
        
        from: root.minValue
        to: root.maxValue

        Binding on value {
            value: root.currentValue
        }
        onMoved: {
            root.currentValue = control.value
        }

        background: Rectangle {
            anchors.fill: control
            color: Catppuccin.surface0
            radius: 10

            Item {
                anchors.left: parent.left
                height: control.height
                width: control.width * (control.visualPosition)
                Behavior on width { NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutExpo
                }}

                clip: true
                Rectangle {
                    width: control.width
                    height: control.height
                    color: Catppuccin.blue
                    radius: 10
                }
            }
        }
        handle: Item {}
    }
}
