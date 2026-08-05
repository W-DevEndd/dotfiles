pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root
    readonly property string wallpapersPath: Quickshell.cachePath("wallpapers")
    readonly property string thumbnailPath: Quickshell.cachePath("thumbnails")
    Component.onCompleted: {
        Quickshell.execDetached(["mkdir", "-p", root.wallpapersPath])
        Quickshell.execDetached(["mkdir", "-p", root.thumbnailPath])
    }

    property var thumbnailQueue: ListModel {
        id: thumbnailQueue
    }
    property var _thumbnailProcessor: Instantiator {
        model: thumbnailQueue
        delegate: QtObject {
            id: thumbnailItem
            property var md: thumbnailQueue.get(index)
            property string cachedPath: {
                var tmp = md.originPath.split('/')
                var baseName = tmp[tmp.length - 1] + ".jpg"
                return [root.thumbnailPath, baseName].join('/')
            }
            property var _proc: Process {
                id: proc
                property int t: 1
                running: true
                command: ["test", "-f", thumbnailItem.cachedPath]
                onExited: (code, _) => {
                    // console.log(code)
                    if (code === 0)
                    return root.thumbnailQueue.setProperty(index, "cachedPath", thumbnailItem.cachedPath)
                    if (proc.t <= 0) return
                    proc.t--
                    Quickshell.execDetached(["rm", "-rf", cachedPath])
                    proc.exec([
                        "ffmpeg", "-ss", "00:00:00",
                        "-i", thumbnailItem.md.originPath,
                        "-vframes", "1", "-q:v", "2",
                        thumbnailItem.cachedPath, "-y",
                    ])
                }
            }
            Component.onCompleted: {
                // console.log(cachedPath)
            }
        }
    }

    function cacheThumbnail(p) {
        for (var i = 0; i < root.thumbnailQueue.count; i++) {
            var md = root.thumbnailQueue.get(i);
            if (md.originPath === p) return md
        }
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
    //         var s = [];
    //         for (var i = 0; i < root.thumbnailQueue.count; i++) {
    //             s.push(JSON.stringify(root.thumbnailQueue.get(i), null, 4))
    //         }
    //         console.log(s.join('\n'))
    //     }
    // }
}
