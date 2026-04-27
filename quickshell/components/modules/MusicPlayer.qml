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
        text: "Unknow track"
        Connections {
            target: Media.players
            // onCountChanged: {
            //     var count = Media.players.count
            //     console.log(count)
            // }
        }
        // Timer {
        //     interval: 1000
        //     repeat: true
        //     running: true
        //     onTriggered: console.log(Media.players.get(0).title)
        // }
    }
}
