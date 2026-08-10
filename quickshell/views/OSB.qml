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

        var vol = SystemStates.sinkVolume

        loader.sourceComponent = sliderComp
        handleLoaded()
        loader.item.currentValue = vol
        loader.item.minValue = 0
        loader.item.maxValue = 100

        loader.item.displayIcon = SystemStates.isMutedSink ? "󰝟" : (
            vol >= 40 ? "󰕾" :
            vol >= 10 ? "󰖀" : "󰕿"
        )
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
            id: r
            property string displayIcon:  "$"
            property string displayValue: currentValue

            property real currentValue: 100
            property real minValue: 0
            property real maxValue: 100

            height: 40
            spacing: 8

            BaseText {
                text: r.displayIcon
                anchors.verticalCenter: r.verticalCenter
            }

            Slider {
                width: 200
                anchors.verticalCenter: r.verticalCenter

                value: r.currentValue
                from: r.minValue
                to: r.maxValue
            }

            BaseText {
                text: r.displayValue
                anchors.verticalCenter: r.verticalCenter
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
