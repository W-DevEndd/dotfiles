import QtQuick
import QtQuick.Controls
import Quickshell.Networking
import "root:/"
import "root:/commons/"

ListView {
    id: root
    required property var parentContentContext

    property int forcussedIndex: 0
    width: subContent.width
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
        width: root.width
        height: wifiControl.height
        clip: true
        Behavior on height { NumberAnimation { duration: 400; easing.type: Easing.InOutExpo } }

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
                root.currentIndex = index
            }
            onClicked: {
                root.forcussedIndex = index
                if (modelData.connected) return
                modelData.connect()
                // if (modelData.known) modelData.connect()
                // else {
                //     wifiControl.showPskPanel = !wifiControl.showPskPanel
                // }
            }
        }

        Column {
            id: wifiControl
            width: wifiItem.width
            height: wifiInfo.height + padding * 2 + (spacing + wifiPasswdInput.height) * showPskPanel
            padding: 10
            spacing: 10

            property var showPskPanel: false
            Connections { target: root; function onForcussedIndexChanged() { if (root.forcussedIndex !== index) wifiControl.showPskPanel = false } }
            Connections { target: root.parentContentContext; function onIsInSubcontentChanged() { wifiControl.showPskPanel = false } }


            Item {
                id: wifiInfo
                width: wifiControl.width - wifiControl.padding * 2
                height: 21

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
                        anchors.centerIn: parent
                        font.bold: true
                    }

                    BaseText {
                        text: modelData.name
                        x: parent.height + 10
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
            TextField {
                id: wifiPasswdInput
                width: wifiControl.width - wifiControl.padding * 2
                background: Rectangle {
                    color: Catppuccin.text
                    height: 2
                    width: parent.width
                    anchors.bottom: parent.bottom
                }

                echoMode: TextInput.Password
                onAccepted: {
                    console.log(wifiPasswdInput.text)
                    modelData.connectWithPsk(wifiPasswdInput.text)
                }

            }
        }
    }
}
