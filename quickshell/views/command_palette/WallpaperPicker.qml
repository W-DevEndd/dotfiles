import QtQuick
import "root:/"
import "root:/commons/"
import "root:/utils/"

Column {
    id: root

    property string inpText: ""
    property string option: inpText.replace("/wallpaper ", '')
    onOptionChanged: {
        if (option.startsWith("cd ")) typingWallsDir = option.replace("cd ", '').trim()
    }

    property string typingWallsDir: ""
    property string wallpapersDir: Pathlibs.userResolve([ShellStates.wallpapersDir, typingWallsDir].join('/'))

    function handleEnter() {
        if (option.startsWith("cd ")) {
            ShellStates.wallpapersDir = root.wallpapersDir
            root.typingWallsDir = ""
            PpStates.cmpHandleAutoComplete("/wallpaper set ")
        }
    }
    property var handleClose: () => {
    }

    BaseText {
        color: Catppuccin.overlay0
        text: root.wallpapersDir
        font.bold: true
    }

    height: 272
}
