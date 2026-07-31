pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "root:/utils/"

QtObject {
    id: root

    readonly property url wallConfUrl: Quickshell.statePath("wall-conf.json")
    property string wallpapersDir: ""
    Binding on wallpapersDir {
        value: root._wallConfListener.parsedData?.wallsDir
    }
    onWallpapersDirChanged: {
        Pathlibs.userResolve(wallpapersDir)
        console.log(wallpapersDir)
        if (wallpapersDir !== _wallConfListener.parsedData.wallsDir) root._wallConfListener.saveConfig()
    }

    Component.onCompleted: {
        Quickshell.execDetached(["touch", wallConfUrl])
        _wallConfListener.path = root.wallConfUrl
    }
    property var _wallConfListener: FileView {
        readonly property var _default_conf: ({
            wallsDir: "~/.wallpaper/",
            currWall: "Elaina",
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
            setData(JSON.stringify(parsedData, null, 4))
        }
    }
}
