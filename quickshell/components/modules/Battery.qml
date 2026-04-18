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
        keyColor: Theme.peach
        key: !UPower.onBattery ? "󰚥" :
        perc >= 90 ? "" :
        perc >= 70 ? "" :
        perc >= 40 ? "" :
        perc >= 10 ? "" :
        ""
        value: perc + "%"
        extraValue: UPower.displayDevice.timeToEmpty
    }
    MouseArea {
        height: parent.height
        width: parent.width
        onClicked: format.useExtraValue = !format.useExtraValue
    }
}
