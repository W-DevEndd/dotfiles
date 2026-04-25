import QtQuick
import Quickshell.Services.Mpris 
import "../base/"

Row {
    width: childrenRect.width
    height: childrenRect.height

    Repeater {
        model: Mpris.players
        ScrollingText {
            text: modelData.trackArtists + " - " + modelData.trackTitle
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 1000
        onTriggered: {
            console.log(Mpris.players)
        }
    }
}
