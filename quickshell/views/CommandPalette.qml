import QtQuick
import QtQuick.Controls
import Quickshell
import "root:/"

Canvas {
    id: root

    property var contentLoaderActive: true
    property var handleClose: () => {}

    property int radius: 0
    property int borderW: 2
    property color borderColor: Catppuccin.crust
    property color color: Catppuccin.base

    Component.onCompleted: {
        cmdInput.forceActiveFocus()
        PpStates.cmpHandleAutoComplete = (text) => { cmdInput.text = text }
    }

    onPaint: {
        const ctx = getContext("2d")
        ctx.fillStyle = root.color
        ctx.strokeStyle = root.borderColor
        ctx.lineWidth = root.borderW

        ctx.beginPath()
        ctx.moveTo(0 - 1, root.height + 1)
        ctx.quadraticCurveTo(
            0 + root.radius, root.height,
            0 + root.radius, root.height - root.radius,
        )
        ctx.lineTo(0 + root.radius, 0 + root.radius)
        ctx.quadraticCurveTo(
            0 + root.radius, 0,
            0 + root.radius + root.radius, 0,
        )
        ctx.lineTo(root.width - root.radius - root.radius, 0)
        ctx.quadraticCurveTo(
            root.width - root.radius, 0,
            root.width - root.radius, 0 + root.radius,
        )
        ctx.lineTo(root.width - root.radius, root.height - root.radius)
        ctx.quadraticCurveTo(
            root.width - root.radius, root.height,
            root.width + 1, root.height + 1,
        )
        ctx.fill()
        ctx.stroke()
    }

    height: content.height
    width: 555
    Behavior on width { NumberAnimation {
        duration: 400
        easing.type: Easing.OutExpo
    }}
    MouseArea { anchors.fill: root }

    Column {
        id: content
        anchors.horizontalCenter: root.horizontalCenter
        width: root.width - root.radius * 2
        padding: 8
        spacing: 8

        Item {
            width: content.width - content.padding * 2
            height: contentLoader.active ? childrenRect.height : 0
            Behavior on height { NumberAnimation {
                duration: 400
                easing.type: Easing.OutExpo
            }}
            clip: true
            Loader {
                id: contentLoader
                width: parent.width
                anchors.bottom: parent.bottom
                active: root.contentLoaderActive
                function handleEnter() { item?.handleEnter() }
                function updateContent() {
                    var props = {
                        width: contentLoader.width,
                        inpText: Qt.binding(function () { return cmdInput.text }),
                        handleClose: root.handleClose
                    }
                    if (cmdInput.text.startsWith("/wallpaper ")) {
                        root.width = 999
                        contentLoader.setSource("./command_palette/WallpaperPicker.qml", props)
                    }
                    else {
                        root.width = 555
                        contentLoader.setSource("./command_palette/Launcher.qml", props)
                    }
                }
            }
        }

        TextField {
            id: cmdInput
            width: content.width - content.padding * 2
            background: Rectangle {
                color: Catppuccin.crust
                radius: 10
            }
            color: Catppuccin.text
            onTextChanged: contentLoader.updateContent()
            Keys.onPressed: (event) => {
                const key = event.key
                if (key === Qt.Key_Down || key === Qt.Key_Tab) {
                    contentLoader.item?.incrementCurrentIndex()
                    event.accepted = true
                } else if (key === Qt.Key_Up || key === Qt.Key_Backtab) {
                    contentLoader.item?.decrementCurrentIndex()
                    event.accepted = true
                } else if (key === Qt.Key_Return) {
                    contentLoader.handleEnter()
                    event.accepted = true
                }
            }
        }

        Timer {
            interval: 50
            running: true
            onTriggered: contentLoader.updateContent()
        }
    }
}
