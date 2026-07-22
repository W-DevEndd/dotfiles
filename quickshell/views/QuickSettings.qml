import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import "root:/"
import "root:/commons/"
import "root:/commons/options/"
import "root:/views/quick_settings/"

PanelWindow {
    id: root

    // visible animation
    property real alpha: Number(PpStates.showQuickSettings)
    Behavior on alpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }
    visible: PpStates.showQuickSettings | alpha !== 0

    color: "transparent"
    property real opacity: 1.0
    property int padding: 5
    property int margin: 6

    // position and size
    anchors {
        top: true
        bottom: true
        right: true
    }
    margins.right: margin - 100 * (1 - root.alpha)
    margins.top: margin

    implicitWidth: 400

    // layer
    exclusionMode: TopLvl.isFullScreen ? ExclusionMode.Ignore : ExclusionMode.Normal
    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay
    Binding on focusable { value: PpStates.showQuickSettings }

    Rectangle {
        id: bg
        color: Catppuccin.base
        border {
            color: Catppuccin.crust
            width: 1
        }
        opacity: root.opacity * root.alpha
        radius: 10

        width: root.width
        height: contentPanel.height + root.padding * 2
    }

    Column {
        id: contentPanel
        opacity: root.opacity * root.alpha

        width: root.implicitWidth - root.padding * 2
        x: root.padding
        y: root.padding

        spacing: 5
        clip: true

        Item {
            id: statusPanel
            width: contentPanel.width
            height: 28

            SmallIconButton {
                height: parent.height
                width: height
            }
        }

        Rectangle {
            color: Catppuccin.surface0
            radius: 5
            width: contentPanel.width
            height: childrenRect.height

            ScrollView {
                width: parent.width
                height: contentLoader.height
                padding: 5

                Loader {
                    id: contentLoader
                    width: parent.width
                    sourceComponent: Item { height: 200 }
                    onLoaded: {
                        item.width = width
                        height = item.height
                    }
                }
            }
        }
    }
}
