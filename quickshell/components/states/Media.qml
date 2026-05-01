pragma Singleton
import QtQuick
import Quickshell.Services.Mpris
import "../utils/"

QtObject {
    id: root
    property ListModel players : ListModel {}
    property var updateIndex: false

    property var _logic: Instantiator {
        model: Mpris.players
        delegate: QtObject {
            readonly property string uuid: Math.random().toString(16).slice(2)
            property int index: 0

            readonly property string title: modelData.trackTitle
            onTitleChanged: root.players.setProperty(index, "title", title)
            readonly property string artists: modelData.trackArtists
            onArtistsChanged: root.players.setProperty(index, "artists", artists)

            readonly property string isPlaying: modelData.isPlaying
            onIsPlayingChanged: root.players.setProperty(index, "isPlaying", isPlaying)

            readonly property var togglePlaying: modelData.togglePlaying

            property var _indexUpdater: Connections {
                target: root
                function onUpdateIndexChanged() {
                    index = ListUtils.getIndexByUUID(root.players, uuid)
                    // console.log(index)
                }
            }
        }
        onObjectAdded: (index, obj) => {
            root.players.insert(0, {
                uuid: obj.uuid,
                title: obj.title,
                artists: obj.artists,

                isPlaying: obj.isPlaying,
                togglePlaying: obj.togglePlaying,
            })
            root.updateIndex = ! root.updateIndex
        }
    }
    // property var _test: Timer {
    //     interval: 1000
    //     repeat: true
    //     running: true
    //     onTriggered: {
    //         for (let i = 0; i < root.players.count; i++) {
    //             let player = root.players.get(i)
    //             console.log(player.uuid)
    //             console.log(player.title)
    //         }
    //     }
    // }
}
