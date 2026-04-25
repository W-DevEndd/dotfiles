import QtQuick
import Quickshell.Services.Mpris 
import "../base/"
import "../states/"

Row {
    width: childrenRect.width
    height: childrenRect.height

    property var thisPlayer
    ScrollingText {
        id: textContent
        function updateText(display) {
            text = display
        }
    }

    Instantiator {
        model: Mpris.players
        delegate: QtObject {
            property string title: modelData.trackTitle || "[No Media]"
            property string artists: modelData.trackArtists || "Unknow"
            property string display: artists + " • " + title

            readonly property var isPlaying: modelData.isPlaying
            onIsPlayingChanged: {
                if (isPlaying) textContent.updateText(display)
            }
            onDisplayChanged: {
                textContent.updateText(display)
            }
        }
    }
}
