import QtQuick
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
    property int padding: 10
    property int margin: 5

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
        height: content.height + root.padding * 2
        Behavior on height { NumberAnimation { duration: 400; easing.type: Easing.InOutQuart } }
    }

    Item {
        id: contentPanel
        opacity: root.opacity * root.alpha

        width: root.implicitWidth - root.padding * 2
        height: content.height + root.padding * 2
        Behavior on height { NumberAnimation { duration: 400; easing.type: Easing.InOutQuart } }
        x: root.padding
        y: root.padding
        clip: true

        Row {
            id: content

            function changeSubcontent(title: string, source: url, opt: var) {
                subContentTitle.text = title
                subcontentLoader.setSource(source, opt)
            }

            property var isInSubcontent: false
            Connections { target: PpStates; function onShowQuickSettingsChanged() { content.isInSubcontent = false } }

            spacing: root.padding
            height: isInSubcontent ? subContent.height : mainContent.height
            x: -(mainContent.width + spacing) * Number(isInSubcontent)
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.InOutQuart } }

            MainSettings {
                id: mainContent
                width: contentPanel.width
                parentContentContext: content
            }

            Column {
                id: subContent
                width: contentPanel.width
                spacing: 8

                Item {
                    width: subContent.width
                    height: 21

                    BaseText {
                        id: subContentTitle
                        text: ""
                        font.bold: true
                        anchors.centerIn: parent
                    }
                    SecondaryButton {
                        displayIcon: ""
                        onClicked: content.isInSubcontent = false
                        anchors.left: parent.left
                        width: height
                        height: parent.height
                    }
                    SwitchToggle {
                        Binding on checked {
                            value: SystemStates.wifiEnabled
                        }
                        onCheckedChanged: SystemStates.wifiEnabled = checked
                        height: parent.height
                        anchors.right: parent.right
                    }
                }

                Loader {
                    id: subcontentLoader
                    width: subContent.width
                    height: childrenRect.height
                    sourceComponent: Item {}
                    onLoaded: { if (item) item.width = width } 
                }
            }
        }
    }
}
