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
        property string title: Media.players.count > 0 ? Media.players.get(0).title : ""
        text: title ? title : "Unknown track"
    }
}
