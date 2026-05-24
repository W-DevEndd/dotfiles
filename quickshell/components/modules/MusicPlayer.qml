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
        property string title: Media.players.count > 1 ? Media.players.get(Media.players.count - 2).title : ""
        text: title ? title : "Unknown track"
    }
}
