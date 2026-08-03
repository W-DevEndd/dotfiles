import Quickshell
import Quickshell.Wayland
import QtQuick
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
        delegate: Image {
            opacity: index === 0 ? 1.0 : 0.0
            Behavior on opacity { NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }}
            Component.onCompleted: opacity = 1.0
            onOpacityChanged: {
                if (opacity === 1.0) wallpaperRenderer.model.remove(index - 1);
            }

            anchors.fill: parent

            source: modelData["path"]
            sourceSize {
                width: root.scrWidth
                height: root.scrHeight
            }
            fillMode: Image.PreserveAspectCrop
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            smooth: true
            // asynchronous: true
            // Timer {
            //     repeat: true
            //     running: true
            //     interval: 1000
            //     onTriggered: console.log(modelData)
            // }
        }
        // onItemAdded: console.log("Aaaa")
        // onItemRemoved: console.log("EEEeeeee")
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
