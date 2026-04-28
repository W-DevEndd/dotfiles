import QtQuick
import Quickshell.Services.Mpris
import QtQml.Models
import "../base/"
import "../states/"

Row {
    width: childrenRect.width
    height: childrenRect.height

    ScrollingText {
        id: textContent
        text: Media.players.count > 0 ? Media.players.get(0).title : ""
        // Timer {
        //     interval: 1000
        //     repeat: true
        //     running: true
        //     onTriggered: console.log(Media.players.get(0).title)
        // }
    }
}
