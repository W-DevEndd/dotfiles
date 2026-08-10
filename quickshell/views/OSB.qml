import QtQuick
import QtQuick.Controls
import "root:/"
import "root:/commons/"

Rectangle {
    id: root

    function handleLoaded() {
        loader.width = loader.item.width
        loader.height = loader.item.height
    }

    function loadSinkSlider() {
        loader.sourceComponent = sliderComp
        handleLoaded()
    }

    property int padding: 5

    height: loader.height + padding * 2
    width: loader.width + padding * 2
    color: Catppuccin.base
    border {
        width: 1
        color: Catppuccin.crust
    }

    Component {
        id: sliderComp
        Row {
            property string displayIcon:  "$"
            property string displayValue: currentValue

            property real currentValue: 100
            property real minValue: 0
            property real maxValue: 100

            height: 40
            spacing: 8

            BaseText {
                text: parent.displayIcon
                anchors.verticalCenter: parent.verticalCenter
            }

            Slider {
                width: 200
                anchors.verticalCenter: parent.verticalCenter
            }

            BaseText {
                text: "100"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Loader {
        id: loader

        x: root.padding
        y: root.padding

        Behavior on height { NumberAnimation {
            duration: 400
            easing.type: Easing.OutBack
        }}
        Behavior on width { NumberAnimation {
            duration: 400
            easing.type: Easing.OutBack
        }}
    }
}
