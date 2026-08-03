pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "root:/utils/"

QtObject {
    id: root

    readonly property url wallConfUrl: Quickshell.statePath("wall-conf.json")
    property string wallpapersDir: ""
    property var currentWallpaper

    Binding on wallpapersDir {
        value: root._wallConfListener.parsedData?.wallsDir
    }
    Binding on currentWallpaper {
        value: root._wallConfListener.parsedData?.currWall
    }



    onWallpapersDirChanged: {
        if (wallpapersDir !== _wallConfListener.parsedData.wallsDir) root._wallConfListener.saveConfig()
    }
    onCurrentWallpaperChanged: {
        if (currentWallpaper !== _wallConfListener.parsedData.currWall) root._wallConfListener.saveConfig()
    }



    Component.onCompleted: {
        Quickshell.execDetached(["touch", wallConfUrl])
        _wallConfListener.path = root.wallConfUrl
    }
    property var _wallConfListener: FileView {
        readonly property var _default_conf: ({
            wallsDir: Pathlibs.userResolve("~/.wallpapers/"),
            currWall: {
                name: "elaina.jpg",
                path: Pathlibs.userResolve("~/.wallpapers/elaina.jpg"),
            }
        })
        property var parsedData: null
        path: ""
        watchChanges: true
        blockWrites: true
        onLoaded: {
            try {
                parsedData = JSON.parse(text())
            } catch(_) {
                setText(JSON.stringify(_default_conf, null, 4))
                parsedData = _default_conf
            }
        }
        function saveConfig() {
            parsedData.wallsDir = root.wallpapersDir
            parsedData.currWall = root.currentWallpaper
            setData(JSON.stringify(parsedData, null, 4))
        }
    }
}
