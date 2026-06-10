pragma Singleton
import Quickshell.Services.UPower
import QtQuick

QtObject {
    property int perc: UPower.displayDevice.percentage * 100
    property string value:  UPower.onBattery ? (
        perc <= 5 ? "󰂎" :
        perc <= 10 ? "󰁺" : 
        perc <= 20 ? "󰁻" : 
        perc <= 30 ? "󰁼" :
        perc <= 40 ? "󰁼" :
        perc <= 50 ? "󰁾" :
        perc <= 60 ? "󰁿" :
        perc <= 70 ? "󰂀" :
        perc <= 80 ? "󰂁" :
        perc <= 90 ? "󰂂" :
    "󰁹") : "󱐋"
}
