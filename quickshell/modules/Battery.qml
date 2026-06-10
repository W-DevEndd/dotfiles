import QtQuick
import Quickshell.Services.UPower
import "../commons/"
import "../vars/"
import "../assets/icons/"

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
            text:  BatteryNerd.value
            anchors.verticalCenter: r.verticalCenter
        }
    }
}
