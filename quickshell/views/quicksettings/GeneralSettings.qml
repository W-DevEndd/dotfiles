import QtQuick
import "root:/"
import "root:/commons/options"

Column {
    id: root

    Item {
        id: statusPanel

        height: 24
        width: root.width

        SmallIconTextButtonWithExtra {
            bgColor: SystemStates.wifiEnabled ? Catppuccin.blue : Catppuccin.surface0
            contentColor: SystemStates.wifiEnabled ? Catppuccin.base : Catppuccin.text

            onClicked: SystemStates.wifiEnabled = !SystemStates.wifiEnabled
            displayIcon: ""
            displayText: "Wifi"

            height: statusPanel.height
            anchors.left: statusPanel.left
        }
        
        SmallIconTextButton {

            displayIcon: (
                SystemStates.isCharging ? "󱐋" :
                SystemStates.batteryPerc >= 95 ? "󰁹" :
                SystemStates.batteryPerc >= 85 ? "󰂂" :
                SystemStates.batteryPerc >= 75 ? "󰂁" :
                SystemStates.batteryPerc >= 65 ? "󰂀" :
                SystemStates.batteryPerc >= 55 ? "󰁿" :
                SystemStates.batteryPerc >= 45 ? "󰁾" :
                SystemStates.batteryPerc >= 35 ? "󰁽" :
                SystemStates.batteryPerc >= 25 ? "󰁼" :
                SystemStates.batteryPerc >= 15 ? "󰁻" :
                SystemStates.batteryPerc >= 5 ? "󰁺" : "󰂎"
            )
            displayText: SystemStates.batteryPerc + "%"
            contentColor: SystemStates.isCharging ? Catppuccin.green : Catppuccin.text

            height: statusPanel.height
            anchors.right: statusPanel.right
        }
    }
}
