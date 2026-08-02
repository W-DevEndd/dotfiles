pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "./"

QtObject {
    id: root

    readonly property string cacheWallpaperDir: Quickshell.cachePath("wallpapers")
    readonly property int scrWidth:  Quickshell.screens[0].width
    readonly property int scrHeight: Quickshell.screens[0].height

    function cachedWallpaperPath(p: string): string {
        Quickshell.execDetached(["mkdir" , "-p", root.cacheWallpaperDir])

        const baseName = p.split("/").pop()
        const cachedP = root.cacheWallpaperDir + '/' + baseName

        const scrRsl = root.scrWidth + 'x' + root.scrHeight

        const command = [
            "magick", 
            p,
            "-resize", scrRsl + "^",
            "-gravity", "center",
            "-extent", scrRsl,
            cachedP,
        ]
        // console.log(command.join(' '))
        Quickshell.execDetached(command)
        return cachedP;
    }
}
