import QtQuick
import "root:/"
import "root:/commons/options"

Column {
    id: root

    SmallIconTextButton {
        bgColor: SystemStates.wifiEnabled ? Catppuccin.surface1 : Catppuccin.surface0
        displayIcon: ""
        displayText: "Wifi"
        height: 24
    }
}
