pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    readonly property int scrWidth:  Quickshell.screens[0].width
    readonly property int scrHeight: Quickshell.screens[0].height

    readonly property string wallpapersPath: Quickshell.cachePath("wallpapers")
    readonly property string thumbnailsPath: Quickshell.cachePath("thumbnails")
    Component.onCompleted: {
        Quickshell.execDetached(["mkdir", "-p", root.wallpapersPath])
        Quickshell.execDetached(["mkdir", "-p", root.thumbnailsPath])
    }

    property var wallpapersQueue: ListModel {
        id: wallpapersQueue
    }
    property var thumbnailsQueue: ListModel {
        id: thumbnailsQueue
    }

    property var _thumbnailProcessors: Instantiator {
        model: thumbnailsQueue
        delegate: QtObject {
            id: thumbnailItem
            property var md: thumbnailsQueue.get(index)
            property string cachedPath: {
                var tmp = md.originPath.split('/')
                var baseName = tmp[tmp.length - 1] + ".jpg"
                return [root.thumbnailsPath, baseName].join('/')
            }
            property var _proc: Process {
                id: thumbnailProc
                property int t: 1
                running: true
                command: ["test", "-f", thumbnailItem.cachedPath]
                onExited: (code, _) => {
                    // console.log(code)
                    if (code === 0)
                    return root.thumbnailsQueue.setProperty(index, "cachedPath", thumbnailItem.cachedPath)
                    if (thumbnailProc.t <= 0) return
                    thumbnailProc.t--
                    thumbnailProc.exec([
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
    property var _wallpaperProcessor: Instantiator {
        model: wallpapersQueue
        delegate: QtObject {
            id: wallpaperItem
            property var md: wallpapersQueue.get(index)
            property string cachedPath: {
                var tmp = md.originPath.split('/')
                var baseName = tmp[tmp.length - 1] + ".jpg"
                return [root.wallpapersPath, baseName].join('/')
            }
            property var _proc: Process {
                id: wallpaperProc
                property int t: 1
                running: true
                command: ["test", "-f", wallpaperItem.cachedPath]
                onExited: (code, _) => {
                    // console.log(code)
                    if (code === 0)
                    return root.wallpapersQueue.setProperty(index, "cachedPath", wallpaperItem.cachedPath)
                    if (wallpaperProc.t <= 0) return
                    wallpaperProc.t--
                    wallpaperProc.exec([
                        "magick", md.originPath,
                        "-resize", root.scrWidth + 'x' + root.scrHeight + '^',
                        "-gravity", "center",
                        "-crop", root.scrWidth + 'x' + root.scrHeight + "+0+0",
                        "-quality", "100", 
                        wallpaperItem.cachedPath,
                    ])
                }
            }
            Component.onCompleted: {
                // console.log(cachedPath)
            }
        }
    }

    function cacheThumbnail(p) {
        for (var i = 0; i < root.thumbnailsQueue.count; i++) {
            var md = root.thumbnailsQueue.get(i);
            if (md.originPath === p) return md
        }
        thumbnailsQueue.append({
            originPath: p,
            cachedPath: "",
        })

        return thumbnailsQueue.get(thumbnailsQueue.count - 1);
    }
    function cacheWallpaper(p) {
        for (var i = 0; i < root.wallpapersQueue.count; i++) {
            var md = root.wallpapersQueue.get(i);
            if (md.originPath === p) return md
        }
        wallpapersQueue.append({
            originPath: p,
            cachedPath: "",
        })

        return wallpapersQueue.get(wallpapersQueue.count - 1);
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
