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

            property var isInSubcontent: false
            Connections { target: PpStates; function onShowMenuPopupChanged() { content.isInSubcontent = false } }

            spacing: root.padding
            height: isInSubcontent ? subContent.height : mainContent.height
            x: -(mainContent.width + spacing) * Number(isInSubcontent)
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.InOutQuart } }


            Column {
                id: mainContent

                width: contentPanel.width

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

                        OptionButtonWithExtra {
                            Layout.fillWidth: true
                            Layout.preferredHeight: buttonsGrid.childrenHeight

                            displayIcon: ""

                            Binding on toggleState {
                                value: SystemStates.wifiEnabled
                            }
                            onPrimaryClick: SystemStates.wifiEnabled = !SystemStates.wifiEnabled
                            onSecondaryClick: content.isInSubcontent = true
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
                width: contentPanel.width
                spacing: 8

                Item {
                    width: subContent.width
                    height: 21

                    BaseText {
                        id: extraContentTitle
                        text: "Wifi"
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

                ListView {
                    id: wifiNetworksList
                    width: subContent.width
                    height: Math.min(377, childrenRect.height)
                    clip: true

                    add: Transition {
                        NumberAnimation { 
                            property: "opacity"
                            from: 0.0
                            to: 1.0
                            duration: 300 
                            easing.type: Easing.OutQuad
                        }

                        NumberAnimation { 
                            property: "y"
                            from: typeof(y) !== 'undefined' ? y + 15 : 0
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }
                    remove: Transition {
                        ParallelAnimation {
                            NumberAnimation { 
                                property: "opacity"
                                to: 0.0
                                duration: 200 
                            }

                            NumberAnimation { 
                                property: "height"
                                to: 0
                                duration: 250
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }



                    model: SystemStates.wifiNetworks
                    highlight: Rectangle {
                        width: wifiNetworksList.width
                        height: 34

                        color: Catppuccin.surface0
                        radius: 10

                        Behavior on y { SpringAnimation {
                                spring: 3
                                damping: 0.2
                                duration: 150
                        } }
                    }
                    highlightMoveDuration: 150
                    highlightFollowsCurrentItem: true
                    delegate: Item {
                        id: wifiItem
                        width: wifiNetworksList.width
                        height: 34

                        MouseArea {
                            id: itemMouseArea
                            anchors.fill: parent

                            hoverEnabled: true 

                            onEntered: {
                                wifiNetworksList.currentIndex = index
                            }
                        }

                        Item {
                            id: wifiControl
                            property int margins: 10
                            width: wifiItem.width - margins * 2
                            height: wifiItem.height - margins * 2
                            x:  margins
                            y: margins

                            Row {
                                height: wifiControl.height
                                width: childrenRect.width
                                anchors.left: wifiControl.left

                                spacing: 10

                                Item {
                                    height: parent.height
                                    width: height

                                    BaseText {
                                        text: {
                                            let strength = modelData.signalStrength;
                                            return (
                                                (strength > 0.80) ? "󰤨" :
                                                (strength > 0.60) ? "󰤨" :
                                                (strength > 0.40) ? "󰤥" :
                                                (strength > 0.20) ? "󰤢" :
                                                (strength > 0.00) ? "󰤟" : "󰤯"
                                            )
                                        }
                                        color: Catppuccin.blue
                                        anchors.fill: parent
                                        font.bold: true
                                    }
                                }

                                BaseText {
                                    text: modelData.name
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
