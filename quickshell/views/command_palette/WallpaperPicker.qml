import QtQuick
import Quickshell.Io
import Quickshell.Widgets
import "root:/"
import "root:/commons/"
import "root:/utils/"

Column {
    id: root

    property string inpText: ""
    property string option: inpText.replace("/wallpaper ", '')
    onOptionChanged: {
        if (option.trim().startsWith("./")) typingWallsDir = option.trim()
    }

    property string typingWallsDir: ""
    property string wallpapersDir: Pathlibs.userResolve([ShellStates.wallpapersDir, typingWallsDir].join('/'))

    function incrementCurrentIndex() { wallpapersView.incrementCurrentIndex() }
    function decrementCurrentIndex() { wallpapersView.decrementCurrentIndex() }
    function handleEnter() {
        if (option.trim().startsWith("./")) {
            ShellStates.wallpapersDir = root.wallpapersDir
            root.typingWallsDir = ""
            PpStates.cmpHandleAutoComplete("/wallpaper ")
        } else {
            ShellStates.currentWallpaper = wallpapersView.model[wallpapersView.currentIndex]
        }
    }
    property var handleClose: () => {
    }
    spacing: 10

    BaseText {
        color: Catppuccin.overlay0
        text: root.wallpapersDir
        font.bold: true
    }

    ListView {
        id: wallpapersView
        width: root.width
        height: (9 / 16) * (width / displayItems)

        orientation: ListView.Horizontal
        highlightRangeMode: ListView.SnapToItem

        preferredHighlightBegin: (width - (width / displayItems - spacing)) / 2
        preferredHighlightEnd: preferredHighlightBegin + (width / displayItems - spacing)
        highlightMoveDuration: 400

        snapMode: ListView.SnapToItem

        model: []
        property int displayItems: 5
        spacing: 10

        onCurrentIndexChanged: console.log(currentIndex)

        delegate: Item {
            id: wallpaperItem
            width: wallpapersView.width / wallpapersView.displayItems - wallpapersView.spacing
            height: wallpapersView.height

            clip: true

            ClippingRectangle {
                radius: 10
                width: ((wallpapersView.currentIndex === index) ? 1.0 : 0.85) * parent.width
                height: ((wallpapersView.currentIndex === index) ? 1.0 : 0.85) * parent.height
                Behavior on width { NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutExpo
                }}
                Behavior on height { NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutExpo
                }}

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                color: "transparent"

                Image {
                    source: modelData.path
                    // sourceSize.width: width
                    // sourceSize.height: height
                    anchors.fill: parent
                    asynchronous: true
                }
            }
            BaseText {
                opacity: 1.0 - Number(wallpapersView.currentIndex === index)
                Behavior on opacity { NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutExpo
                }}
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                text: modelData.name
            }
        }
    }

    Item {
        id: wallpapersCollector
        property string wallsDir: ""
        Binding on wallsDir { value: root.wallpapersDir }
        onWallsDirChanged: {
            console.log(wallsDir)
            proc.exec(["ls", wallsDir])
        }

        property var proc: Process {
            stdout: StdioCollector {
                onStreamFinished: {
                    let focusedIndex = 0;
                    let wallpapers = []
                    const exts = [
                        ".png",
                        ".jpeg",
                        ".jpg",
                        ".webp",
                    ]
                    const files = this.text.split(/\s+/).filter(file => {
                        var tmp = file.split('.');
                        var fExt = '.' + tmp[tmp.length - 1];
                        return exts.includes(fExt);
                    })
                    files.forEach((f, i) => {
                        wallpapers.push({
                            name: f,
                            path: [wallpapersCollector.wallsDir, f].join('/'),
                        })
                        if (f === ShellStates.currentWallpaper.name)
                            focusedIndex = i
                    })
                    wallpapersView.model = wallpapers
                    wallpapersView.currentIndex = focusedIndex
                }
            }
        }
    }
}
