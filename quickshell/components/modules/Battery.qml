import QtQuick
import Quickshell.Services.UPower 
import Quickshell.Io
import "../base/"

KeyValueFormat {
    readonly property int perc: UPower.displayDevice.percentage * 100
    keyColor: Theme.peach
    key: perc >= 90 ? "" :
    perc >= 70 ? "" :
    perc >= 40 ? "" :
    perc >= 10 ? "" :
    ""
    value: perc + "%"
}
