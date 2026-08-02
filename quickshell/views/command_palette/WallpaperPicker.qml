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

    function incrementCurrentIndex() { wallpapersView.incrementCurrentIndex() }
    function decrementCurrentIndex() { wallpapersView.decrementCurrentIndex() }
    function handleEnter() {
        if (option.startsWith("cd ")) {
            ShellStates.wallpapersDir = root.wallpapersDir
            root.typingWallsDir = ""
            PpStates.cmpHandleAutoComplete("/wallpaper set ")
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
        highlightRangeMode: ListView.ApplyRange

        preferredHighlightBegin: (width - (width / displayItems - spacing)) / 2
        preferredHighlightEnd: preferredHighlightBegin + (width / displayItems - spacing)
        highlightMoveDuration: 400

        snapMode: ListView.SnapToItem


        model: ShellStates.wallpapersList
        property int displayItems: 5
        spacing: 10

        onCurrentIndexChanged: console.log(currentIndex)
        delegate: Item {
            width: wallpapersView.width / wallpapersView.displayItems - wallpapersView.spacing
            height: wallpapersView.height

            Rectangle {
                radius: 10
                width: ((wallpapersView.currentIndex === index) ? 1.0 : 0.85) * parent.width
                height: ((wallpapersView.currentIndex === index) ? 1.0 : 0.85) * parent.height
                Behavior on width { NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutExpo
                }}
                Behavior on height { NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutExpo
                }}
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

            }
            BaseText {
                opacity: 1.0 - Number(wallpapersView.currentIndex === index)
                Behavior on opacity { NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutExpo
                }}
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                text: "AAAAAAAaaaaaaaa.png"
            }
        }
    }
}
