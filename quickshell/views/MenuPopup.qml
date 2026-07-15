import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "root:/"
import "root:/commons/"
import "root:/commons/options/"

PanelWindow {
    id: root

    // visible animation
    property real alpha: Number(PpStates.showMenuPopup)
    Behavior on alpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }
    visible: PpStates.showMenuPopup | alpha !== 0

    color: "transparent"
    property real opacity: 1.0
    property int padding: 10
    property int margin: 5

    // position and size
    anchors {
        top: true
        right: true
    }
    margins.right: margin - 100 * (1 - root.alpha)
    margins.top: margin

    implicitWidth: 400
    implicitHeight: content.height

    // layer
    exclusionMode: TopLvl.isFullScreen ? ExclusionMode.Ignore : ExclusionMode.Normal
    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay

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
        height: root.height
    }

    Row {
        id: content
        property var isInSubcontent: false

        opacity: root.opacity * root.alpha
        spacing: root.padding
        height: isInSubcontent ? subContent.height : mainContent.height
        x: -(mainContent.width + spacing) * Number(isInSubcontent)

        Column {
            id: mainContent

            width: root.implicitWidth - root.padding * 2
            padding: root.padding

            spacing: 10

            Item {
                id: buttonPanel
                property int padding: 5
                width: mainContent.width
                height: childrenRect.height + padding * 2

                GridLayout {
                    id: buttonsGrid
                    width: buttonPanel.width - buttonPanel.padding * 2
                    property int childrenHeight: 55

                    anchors.horizontalCenter: buttonPanel.horizontalCenter
                    y: buttonPanel.padding

                    columns: 3
                    rowSpacing: 13
                    columnSpacing: 13
                    flow: Grid.LeftToRight

                    OptionButton {
                        displayIcon: ""
                        Layout.fillWidth: true
                        Layout.preferredHeight: buttonsGrid.childrenHeight

                        Binding on toggleState {
                            value: SystemStates.wifiEnabled
                        }
                        onClicked: SystemStates.wifiEnabled = !SystemStates.wifiEnabled
                    }
                    OptionButton {
                        Layout.fillWidth: true
                        Layout.preferredHeight: buttonsGrid.childrenHeight
                    }
                    OptionButton {
                        Layout.fillWidth: true
                        Layout.preferredHeight: buttonsGrid.childrenHeight
                    }
                    OptionButton {
                        Layout.fillWidth: true
                        Layout.preferredHeight: buttonsGrid.childrenHeight
                    }
                    OptionButton {
                        Layout.fillWidth: true
                        Layout.preferredHeight: buttonsGrid.childrenHeight
                    }
                }
            }

            Column {
                id: sliderPanel
                width: mainContent.width

                spacing: 8

                OptionSlider {
                    id: sinkAudioSlider
                    height: 34
                    width: parent.width

                    displayIcon: SystemStates.isMutedSink ? "" : (
                        currentValue >= 40 ? "" :
                        currentValue >= 10 ? "" : ""
                    )

                    minValue: 0
                    maxValue: 100
                    sliderStep: 1
                    Binding on currentValue {
                        value: SystemStates.sinkVolume
                    }

                    onCurrentValueChanged: SystemStates.sinkVolume = sinkAudioSlider.currentValue
                    clickIconHandle: () => SystemStates.isMutedSink = !SystemStates.isMutedSink
                }
                OptionSlider {
                    id: sourceAudioSlider
                    height: 34
                    width: parent.width

                    displayIcon: SystemStates.isMutedSource ? "" : ""

                    minValue: 0
                    maxValue: 100
                    sliderStep: 1
                    Binding on currentValue {
                        value: SystemStates.sourceVolume
                    }

                    onCurrentValueChanged: SystemStates.sourceVolume = sourceAudioSlider.currentValue
                    clickIconHandle: () => SystemStates.isMutedSource = !SystemStates.isMutedSource
                }
                OptionSlider {
                    id: briSlider
                    height: 34
                    width: parent.width

                    displayIcon: (
                        currentValue > 96 ? "" :
                        currentValue > 88 ? "" :
                        currentValue > 80 ? "" :
                        currentValue > 73 ? "" :
                        currentValue > 65 ? "" :
                        currentValue > 57 ? "" :
                        currentValue > 50 ? "" :
                        currentValue > 42 ? "" :
                        currentValue > 34 ? "" :
                        currentValue > 26 ? "" :
                        currentValue > 19 ? "" :
                        currentValue > 11 ? "" :
                        currentValue > 3 ? "" : ""
                    )

                    property real minValue: 0
                    property real maxValue: 100
                    property real sliderStep: 1
                    Binding on currentValue {
                        value: SystemStates.brightnessVolume
                    }

                    onCurrentValueChanged: SystemStates.brightnessVolume = briSlider.currentValue
                }
            }
        }

        Column {
            id: subContent
            width: root.width - root.padding * 2
            padding: root.padding

            Rectangle {
                width: subContent.width
                height: 100
            }
        }
    }
}
