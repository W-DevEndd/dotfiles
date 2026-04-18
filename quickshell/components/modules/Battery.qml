import QtQuick
import Quickshell.Services.UPower 
import Quickshell.Io
import "../base/"

Item {
    visible: UPower.displayDevice.isLaptopBattery
    height: format.height
    width: format.width
    KeyValueFormat {
        id: format
        readonly property int perc: UPower.displayDevice.percentage * 100
        readonly property int fullIn: Math.floor(UPower.displayDevice.timeToFull / 60)
        readonly property int emptyIn: Math.floor(UPower.displayDevice.timeToEmpty / 60)
        keyColor: Theme.peach
        key: !UPower.onBattery ? "󰚥" :
        perc >= 90 ? "" :
        perc >= 70 ? "" :
        perc >= 40 ? "" :
        perc >= 10 ? "" :
        ""
        value: perc + "%"
        extraValue: UPower.onBattery ?
            Math.floor(emptyIn / 60) + "h " + emptyIn % 60 + "m":
            Math.floor(fullIn / 60) + "h " + fullIn % 60 + "m"
    }

    Process {
        id: refetchPowerTime
        command: []
    }
    MouseArea {
        height: parent.height
        width: parent.width
        onClicked: format.useExtraValue = !format.useExtraValue
    }
}
