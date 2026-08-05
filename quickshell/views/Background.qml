import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtMultimedia
import "root:/"
import "root:/utils/"

PanelWindow {
    id: root

    readonly property int scrWidth:  Quickshell.screens[0].width
    readonly property int scrHeight: Quickshell.screens[0].height

    WlrLayershell.layer: WlrLayer.Background
    exclusionMode: ExclusionMode.Ignore

    color: "transparent"
    
    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    Repeater {
        id: wallpaperRenderer
        model: ListModel {}
        delegate: ClippingRectangle {
            id: clipPanel
            property real openProgress: index === 0 ? 1.0 : 0.0
            property int startX: Math.floor(Math.random() * (root.scrWidth  - 600)) + 300
            property int startY: Math.floor(Math.random() * (root.scrHeight - 600)) + 300

            width: root.scrWidth * 2 * openProgress
            height: width
            Behavior on openProgress { NumberAnimation {
                duration: 3000
                easing.type: Easing.InOutQuad
            }}
            Component.onCompleted: {
                openProgress = 1.0
            }
            onOpenProgressChanged: {
                if (wallpaperRenderer.model.count <= 1) return
                if (openProgress === 1.0) {
                    wallpaperRenderer.model.remove(index - 1)
                }
            }
            x: startX - width / 2
            y: startY - height / 2


            color: "transparent"

            radius: width / 2

            Loader {
                id: wallpaperLoader

                height: root.height
                width: root.width
                x: 0 + clipPanel.height / 2 - clipPanel.startX
                y: 0 + clipPanel.height / 2 - clipPanel.startY

                sourceComponent: modelData.type === "image" ? imageComp : videoComp

                Component {
                    id: videoComp
                    Item {
                        MediaPlayer {
                            id: player
                            source: modelData.path
                            loops: MediaPlayer.Infinite
                            videoOutput: videoOutputId
                            audioOutput: null
                            autoPlay: true
                        }
                        VideoOutput {
                            id: videoOutputId
                            anchors.fill: parent
                            fillMode: VideoOutput.PreserveAspectCrop
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: player.playing ? player.pause() : player.play()
                        }
                    }
                }
                Component {
                    id: imageComp
                    Image {
                        source: modelData.path
                        sourceSize {
                            width: root.scrWidth
                            height: root.scrHeight
                        }
                        anchors.fill: parent

                        fillMode: Image.PreserveAspectCrop
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        smooth: true
                    }
                }
            }
        }
        // onItemAdded: console.log("Aaaa")
        // onItemRemoved: (item) => {
        //     console.log(item)
        // }
        // property var _test: Timer {
        //     interval: 1000
        //     repeat: true
        //     running: true
        //     onTriggered: {
        //         console.log(wallpaperRenderer.model.count)
        //         // for (var i = 0; i < )
        //     }
        // }
    }

    Connections {
        target: ShellStates
        function onCurrentWallpaperChanged() {
            wallpaperRenderer.model.append({ "path": ShellStates.currentWallpaper })
        }
    }
}
