import QtQuick
import QtQuick.Controls
import "root:/"
import "root:/commons/options"

Column {
    id: root

    required property var parentContentContext

    spacing: 16

    Item {
        id: statusPanel

        height: 24
        width: root.width

        SmallIconTextButtonWithExtra {
            contentColor: SystemStates.wifiEnabled ? Catppuccin.blue : Catppuccin.text

            onClicked: SystemStates.wifiEnabled = !SystemStates.wifiEnabled
            onSecondaryClicked: {
                parentContentContext.isInExtraContent = true
                parentContentContext.loadExtraContent("quicksettings/WifiSetting.qml", {
                    parentContentContext: root.parentContentContext
                })
            }

            property var connectedWifi: SystemStates.connectedWifi
            property var wifiStreight: connectedWifi?.signalStrength ?? 0.0

            displayIcon: (
                !connectedWifi ? "󰤭" :
                (wifiStreight > 0.80) ? "󰤨" :
                (wifiStreight > 0.60) ? "󰤨" :
                (wifiStreight > 0.40) ? "󰤥" :
                (wifiStreight > 0.20) ? "󰤢" :
                (wifiStreight > 0.00) ? "󰤟" : "󰤯"

            )
            displayText: connectedWifi?.name ?? "Wifi"

            height: statusPanel.height
            anchors.left: statusPanel.left
        }

        SmallIconTextButton {

            displayIcon: (
                SystemStates.isCharging ? "󱐋" :
                SystemStates.batteryPerc >= 95 ? "󰁹" :
                SystemStates.batteryPerc >= 85 ? "󰂂" :
                SystemStates.batteryPerc >= 75 ? "󰂁" :
                SystemStates.batteryPerc >= 65 ? "󰂀" :
                SystemStates.batteryPerc >= 55 ? "󰁿" :
                SystemStates.batteryPerc >= 45 ? "󰁾" :
                SystemStates.batteryPerc >= 35 ? "󰁽" :
                SystemStates.batteryPerc >= 25 ? "󰁼" :
                SystemStates.batteryPerc >= 15 ? "󰁻" :
                SystemStates.batteryPerc >= 5 ? "󰁺" : "󰂎"
            )
            displayText: SystemStates.batteryPerc + "%"
            contentColor: SystemStates.isCharging ? Catppuccin.green : Catppuccin.text

            height: statusPanel.height
            anchors.right: statusPanel.right
        }
    }

    ScrollView {
        width: root.width
        height: Math.min(settingsPanel.height, 300)

        // padding: 5

        Column {
            id: settingsPanel
            width: parent.width
            spacing: 5

            OptionSlider {
                id: sinkAudioSlider
                height: 34
                width: parent.width

                displayIcon: SystemStates.isMutedSink ? "󰝟" : (
                    currentValue >= 40 ? "󰕾" :
                    currentValue >= 10 ? "󰖀" : "󰕿"
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
            Item { height: 5; width: parent.width}

            Item {
                id: powerProfileControl
                width: parent.width
                height: 40

                property int padding: 16

                Rectangle {
                    color: Catppuccin.surface0
                    radius: 10
                    anchors.centerIn: powerProfileControl
                    height: powerProfileControl.height
                    width: powerProfileControl.width - powerProfileControl.padding * 2

                    Rectangle {
                        color: Catppuccin.green
                        radius: 10
                        height: parent.height
                        width: parent.width / 3
                        x: width * SystemStates.powerProfiles.indexOf(SystemStates.powerProfile)
                        Behavior on x { NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutExpo
                        }}

                    }

                    Row {
                        width: parent.width
                        height: parent.height
                        spacing: 0
                        Repeater {
                            model: 3
                            delegate: OptionButton {
                                displayIcon: (
                                    modelData === 0 ? "󰌪" :
                                    modelData === 1 ? "󰗑" : "󰓅"
                                )
                                contentColor: (
                                    SystemStates.powerProfile === SystemStates.powerProfiles[modelData] ? Catppuccin.crust : Catppuccin.text
                                )
                                Behavior on contentColor { ColorAnimation {
                                    duration: 400
                                    easing.type: Easing.InOutExpo
                                }}
                                bgColor: "transparent"
                                height: parent.height
                                width: parent.width / 3

                                property var clickable: SystemStates.powerProfile != SystemStates.powerProfiles[modelData]
                                onClicked: if (clickable) SystemStates.powerProfile = SystemStates.powerProfiles[modelData]
                                HoverHandler { enabled: parent.clickable; cursorShape: Qt.PointingHandCursor }
                            }
                        }
                    }
                }
            }
        }
    }
}
