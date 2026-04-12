import QtQuick
import Quickshell.Services.UPower 
import Quickshell.Io
import "../base/"

Row {
    // spacing: 10
    height: childrenRect.height
    width: childrenRect.width

    KeyValueFormat {
        readonly property int perc: UPower.displayDevice.percentage * 100
        keyColor: Theme.green
        key: perc >= 90 ? "" :
            perc >= 70 ? "" :
            perc >= 40 ? "" :
            perc >= 10 ? "" :
            ""
        value: perc + "%"
    }

    Item { height: parent.height; width: 10 }

    KeyValueFormat {
        keyColor: Theme.blue
        key: "󰍛"
        value: "0" + "%"

        Process { 
            id: cpuProcess

        }
    }
}
