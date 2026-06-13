import QtQuick
import QtQuick.Controls
import Quickshell.Services.UPower
import "../commons/"
import "../vars/"
import "../assets/icons/"

Item {
    id: root

    property var onBat: UPower.onBattery
    property int batPerc: UPower.displayDevice.percentage * 100

    width: panel.width

    Button {
        id: btn
        anchors.fill: root
        onClicked: PopupStates.toggleShowPowerPopup()
        background: Rectangle {
            visible: PopupStates.showPowerPopup
            radius: 5
            color: Styles.primary2 
        }
    }

    HoverHandler {
        id: hoverHandler
    }

    Item {
        id: panel
        height: r.height
        width: (hoverHandler.hovered || root.onBat || UPower.displayDevice.timeToFull !== 0 || PopupStates.showPowerPopup) ? r.width : iconDisplay.width
        Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutExpo } }

        clip: true

        Row {
            id: r

            anchors.right: panel.right

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
}
