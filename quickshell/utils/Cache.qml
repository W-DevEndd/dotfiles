pragma Singleton
import QtQuick
import Quickshell

QtObject {
    id: root
    readonly property string wallpapersPath: Quickshell.cachePath("wallpapers")
    readonly property string thumbnailPath: Quickshell.cachePath("thumbnailPath")

    property var thumbnailQueue: ListModel {
        id: thumbnailQueue
    }
    property var _thumbnailProcessor: Instantiator {
        model: thumbnailQueue
        delegate: QtObject {
            Component.onCompleted: {
                thumbnailQueue.setProperty(index, "cachedPath", "aaaaaa")
            }
        }
    }

    function cacheThumbnail(p) {
        // for (var i = 0; i < thumbnailQueue.count; i++) {
        //     var modelData = cacheThumbnail.get(i)
        //     if (modelData.originPath === p) return modelData;
        // }

        thumbnailQueue.append({
            originPath: p,
            cachedPath: "",
        })

        return thumbnailQueue.get(thumbnailQueue.count - 1);
    }

    // property var _test: Timer {
    //     interval: 1000
    //     repeat: true
    //     running: true
    //     onTriggered: {
    //         console.log(JSON.stringify(root.thumbnailQueue, null, 4))
    //     }
    // }
}
