import QtQuick
import Quickshell.Services.Mpris
import QtQml.Models
import "../base/"
import "../states/"
import "../assets/"

Row {
    id: root

    property var followingMedia: Media.players.count > 1 ? Media.players.get(Media.players.count - 2) : undefined
    width: childrenRect.width
    height: childrenRect.height

    spacing: 10

    PlayingToggle {
        height: parent.height

        MouseArea {
            property var clickToggle: root.followingMedia ? root.followingMedia.togglePlaying : {}
            anchors.fill: parent
            onClicked: clickToggle()
        }
    }
    ScrollingText {
        id: textContent
        property string title: root.followingMedia ? root.followingMedia.title : ""
        text: title ? title : "Unknown track"
    }
}
