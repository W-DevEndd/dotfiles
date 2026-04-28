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
            property int index: -1
            readonly property string uuid: Math.random().toString(16).slice(2)
            readonly property string title: modelData.trackTitle
            onTitleChanged: root.players.setProperty(index, "title", title)

            property var _indexUpdater: Connections {
                target: root
                onUpdateIndexChanged: {
                    index = ListUtils.getIndexByUUID(root.players, uuid)
                    // console.log(index)
                }
            }
        }
        onObjectAdded: (index, obj) => {
            root.players.insert(0, {
                uuid: obj.uuid,
                title: obj.title,
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
