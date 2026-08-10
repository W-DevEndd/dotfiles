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

    function loadSourceSlider() {

        var vol = SystemStates.sourceVolume

        loader.sourceComponent = sliderComp
        handleLoaded()
        loader.item.currentValue = vol
        loader.item.minValue = 0
        loader.item.maxValue = 100

        loader.item.displayIcon = SystemStates.isMutedSource ? "" : ""
    }

    function loadBrightnessSlider() {

        var vol = SystemStates.brightnessVolume

        loader.sourceComponent = sliderComp
        handleLoaded()
        loader.item.currentValue = vol
        loader.item.minValue = 0
        loader.item.maxValue = 100

        loader.item.displayIcon = (
            vol > 96 ? "" :
            vol > 88 ? "" :
            vol > 80 ? "" :
            vol > 73 ? "" :
            vol > 65 ? "" :
            vol > 57 ? "" :
            vol > 50 ? "" :
            vol > 42 ? "" :
            vol > 34 ? "" :
            vol > 26 ? "" :
            vol > 19 ? "" :
            vol > 11 ? "" :
            vol > 3 ? "" : ""
        )
    }

    function loadSinkMuteState() {
        loader.sourceComponent = superBigIconComp
        handleLoaded()
    }

    property int padding: 10

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

                background: Rectangle {
                    color: Catppuccin.overlay0
                    width: parent.width
                    height: 3
                    radius: height / 2
                    anchors.verticalCenter: parent.verticalCenter
                }

                handle: Rectangle {
                    x: parent.visualPosition * parent.width - width / 2
                    implicitWidth: 3
                    implicitHeight: 16
                    radius: implicitWidth / 2
                    color: Catppuccin.blue
                }
            }

            BaseText {
                text: r.displayValue
                anchors.verticalCenter: r.verticalCenter
            }
        }
    }

    Component {
        id: superBigIconComp
        BaseText {
            text: "$"
            font.pointSize: 24
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
