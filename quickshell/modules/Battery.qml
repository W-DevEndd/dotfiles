import QtQuick
import Quickshell.Services.UPower
import "../commons/"
import "../vars/"

Item {
    id: root

    property var onBat: UPower.onBattery
    property int batPerc: UPower.displayDevice.percentage * 100

    width: r.width

    MouseArea {
        anchors.fill: root
        onClicked: PopupStates.toggleShowPowerPopup()
    }
    Row {
        id: r
        Label {
            id: textDisplay
            text: root.batPerc + "%"
            anchors.verticalCenter: r.verticalCenter
        }
        Label {
            id: iconDisplay
            text:  root.onBat ? (root.batPerc <= 5 ? "󰂎" :
            root.batPerc <= 10 ? "󰁺" : 
            root.batPerc <= 20 ? "󰁻" : 
            root.batPerc <= 30 ? "󰁼" :
            root.batPerc <= 40 ? "󰁼" :
            root.batPerc <= 50 ? "󰁾" :
            root.batPerc <= 60 ? "󰁿" :
            root.batPerc <= 70 ? "󰂀" :
            root.batPerc <= 80 ? "󰂁" :
            root.batPerc <= 90 ? "󰂂" :
            "󰁹") : "󱐋"
            anchors.verticalCenter: r.verticalCenter
        }
    }
}
