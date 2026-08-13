import QtQuick
import QtQuick.Controls
import "root:/"
import "root:/commons/"

Rectangle {
    id: root

    function handleLoad(comp) {
        loader.sourceComponent = comp
        // console.log(loader.item.width)
        // console.log(loader.item.height)
    }

    function loadSinkSlider() {
        handleLoad(sliderComp)

        var vol = SystemStates.sinkVolume

        loader.item.currentValue = vol
        loader.item.minValue = 0
        loader.item.maxValue = 100

        loader.item.displayIcon = SystemStates.isMutedSink ? "󰝟" : (
            vol >= 40 ? "󰕾" :
            vol >= 10 ? "󰖀" : "󰕿"
        )
    }

    function loadSourceSlider() {
        handleLoad(sliderComp)

        var vol = SystemStates.sourceVolume

        loader.item.currentValue = vol
        loader.item.minValue = 0
        loader.item.maxValue = 100

        loader.item.displayIcon = SystemStates.isMutedSource ? "" : ""
    }

    function loadBrightnessSlider() {
        handleLoad(sliderComp)

        var vol = SystemStates.brightnessVolume

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

    property int padding: 10

    height: loader.height + padding * 2
    width: loader.width + padding * 2

    Behavior on height { NumberAnimation {
        duration: 400
        easing.type: Easing.OutBack
    }}
    Behavior on width { NumberAnimation {
        duration: 400
        easing.type: Easing.OutBack
    }}

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
                    color: Catppuccin.text
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
                    color: Catppuccin.text
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
        Item {
            id: superBigIcon
            property string displayIcon: "$"
            width: 64
            height: 64
            BaseText {
                text: superBigIcon.displayIcon
                anchors.centerIn: parent
                font.pointSize: 32
            }
        }
    }

    clip: true

    Loader {
        id: loader

        anchors.centerIn: root

        x: root.padding
        y: root.padding
    }

    MouseArea {
        anchors.fill: root
    }
}
