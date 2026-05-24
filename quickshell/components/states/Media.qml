pragma Singleton
import QtQuick
import Quickshell.Services.Mpris
import "../utils/"

QtObject {
    id: root
    property ListModel players : ListModel { ListElement {} }
    property var updateIndex: false

    property var _logic: Instantiator {
        model: Mpris.players
        delegate: QtObject {
            readonly property string uuid: Math.random().toString(16).slice(2)
            property int index: { index = root.players.count - 1 }

            readonly property string title: modelData.trackTitle
            onTitleChanged: root.players.setProperty(index, "title", title)
            readonly property string artists: modelData.trackArtists
            onArtistsChanged: root.players.setProperty(index, "artists", artists)

            readonly property string isPlaying: modelData.isPlaying
            onIsPlayingChanged: root.players.setProperty(index, "isPlaying", isPlaying)

            readonly property var togglePlaying: modelData.togglePlaying

            Component.onCompleted: {
                root.players.setProperty(index, "togglePlaying", togglePlaying)
            }

            property var _indexUpdater: Connections {
                target: root
                function onUpdateIndexChanged() {
                    index = ListUtils.getIndexByUUID(root.players, uuid)
                    // console.log(index)
                }
            }

            // property var _listener: Connections {
            //     target: modelData
            // }
        }
        onObjectAdded: (index, obj) => {
            root.players.append({})
        }
        onObjectRemoved: (index, obj) => {
            root.players.remove(obj.index)
            root.updateIndex = !root.updateIndex
        }
    }
    // property var _test: Timer {
    //     interval: 1000
    //     repeat: true
    //     running: true
    //     onTriggered: {
    //         console.log(Media.players.get(Media.players.count - 2).isPlaying)
    //     }
    // }
}
