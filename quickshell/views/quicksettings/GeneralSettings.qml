import QtQuick
import "root:/"
import "root:/commons/options"

Column {
    id: root

    Row {
        id: statusPanel

        height: 24
        spacing: 16

        SmallIconTextButtonWithExtra {
            bgColor: SystemStates.wifiEnabled ? Catppuccin.blue : Catppuccin.surface0
            contentColor: SystemStates.wifiEnabled ? Catppuccin.base : Catppuccin.text

            onClicked: SystemStates.wifiEnabled = !SystemStates.wifiEnabled
            displayIcon: ""
            displayText: "Wifi"

            height: statusPanel.height
        }
    }
}
