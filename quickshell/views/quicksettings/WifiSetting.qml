import QtQuick
import QtQuick.Controls
import Quickshell.Networking
import "root:/"
import "root:/commons"
import "root:/commons/options"

Column {
    id: root

    required property var parentContentContext
    height: 400

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
        height: 377
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

            width: wifiList.width
            height: 34
            clip: true

            Connections {
                target: modelData
                function onConnectionFailed(res) {
                    if (res === ConnectionFailReason.NoSecrets) modelData.forget()
                }
            }

            MouseArea {
                id: itemMouseArea
                anchors.fill: parent

                hoverEnabled: true 

                onEntered: {
                    wifiList.currentIndex = index
                }
                onClicked: {
                    wifiList.forcussedIndex = index
                    if (modelData.connected) return
                    modelData.connect()
                }
            }

            Item {
                id: wifiControl
                width: wifiItem.width
                height: wifiItem.height

                Row {
                    height: wifiControl.height
                    width: childrenRect.height
                    anchors.left: wifiControl.left

                    padding: 8
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
                        color: Catppuccin.blue
                        font.bold: true
                    }

                    BaseText {
                        text: modelData.name
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
                            modelData.known ?     "" : ""
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
        }
    }
}

