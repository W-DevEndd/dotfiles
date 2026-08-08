import QtQuick
import QtQuick.Controls
import Quickshell.Networking
import "root:/"
import "root:/commons"
import "root:/commons/options"

Column {
    id: root

    required property var parentContentContext
    height: childrenRect.height

    spacing: 16

    Item {
        id: headerPanel
        width: root.width
        height: 24

        SmallIconButton {
            displayIcon: ""
            anchors.left: headerPanel.left
            height: headerPanel.height
            width: height
            onClicked: root.parentContentContext.isInExtraContent = false
            HoverHandler { cursorShape: Qt.PointingHandCursor}
        }

        BaseText {
            text: "Wifi"
            anchors.centerIn: headerPanel
        }

        SwitchToggle {
            Binding on checked {
                value: SystemStates.wifiEnabled
            }
            onCheckedChanged: SystemStates.wifiEnabled = checked
            height: headerPanel.height
            anchors.right: headerPanel.right
        }
    }

    ListView {
        id: wifiList
        property int forcussedIndex: 0
        width: root.width
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
            width: root.width
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

            property var showPskPanel: (wifiList.forcussedIndex === index) && !modelData.known
            width: wifiList.width
            height: wifiCol.height
            clip: true

            Connections {
                target: modelData
                function onConnectionFailed(res) {
                    if (res === ConnectionFailReason.NoSecrets) {
                        modelData.forget()
                        wifiList.forcussedIndex = index
                    }
                }
            }

            MouseArea {
                id: itemMouseArea
                anchors.fill: parent

                hoverEnabled: true 
                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onEntered: {
                    wifiList.currentIndex = index
                }
                onClicked: {
                    wifiList.forcussedIndex = -1
                    if (modelData.connected) return
                    modelData.connect()
                    // else {
                    //     wifiItem.showPskPanel = !wifiItem.showPskPanel
                    // }
                }
            }

            Column {
                id: wifiCol
                width: wifiItem.width
                height: childrenRect.height + padding * 2
                padding: 8

                Item {
                    id: wifiControl
                    width: wifiCol.width - wifiCol.padding * 2
                    height: 28

                    Row {
                        height: wifiControl.height
                        width: childrenRect.width
                        anchors.left: wifiControl.left

                        // padding: 8
                        spacing: 5

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
                            anchors.verticalCenter: parent.verticalCenter
                            color: Catppuccin.blue
                            font.bold: true
                        }

                        BaseText {
                            text: modelData.name
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Item {
                        id: wifiState
                        height: parent.height
                        width: height

                        anchors.right: parent.right

                        BaseText {
                            id: wifiStateIcon
                            property var loadingFrames: [ "", "", "", "", "", "" ]
                            property int currentLoadingFrameIndex: 0

                            text: (
                                modelData.stateChanging ? loadingFrames[currentLoadingFrameIndex] :
                                modelData.connected ? "" :
                                modelData.known ?     "" : ""
                            )
                            color: modelData.connected ? Catppuccin.green : Catppuccin.overlay2
                            font.bold: true
                            anchors.centerIn: parent
                        }

                        NumberAnimation {
                            target: wifiStateIcon
                            property: "currentLoadingFrameIndex"
                            from: 0
                            to: 5
                            duration: 800
                            loops: Animation.Infinite

                            easing.type: Easing.Linear
                            running: modelData.stateChanging
                        }
                    }
                }
                TextField {
                    id: wifiPskInput
                    height: wifiItem.showPskPanel ? 24 : 0
                    width: wifiCol.width - wifiCol.padding * 2
                    visible: wifiItem.showPskPanel

                    onVisibleChanged: if (visible) {
                        text = ""
                        forceActiveFocus()
                    }
                    onAccepted: modelData.connectWithPsk(text)
                    echoMode: TextInput.Password

                    background: Rectangle {
                        width: parent.width
                        height: 1
                        // radius: height / 2
                        anchors.bottom: parent.bottom
                        color: Catppuccin.text
                    }
                }
            }
        }
    }
    Item { width: root.width; height: 1}
}

