import QtQuick
import QtQuick.Layouts
import "root:/"
import "root:/commons/"
import "root:/commons/options/"

Column {
    id: root
    required property var parentContentContext

    spacing: 10

    Item {
        id: buttonPanel
        property int padding: 5
        width: root.width
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
                onSecondaryClick: {
                    root.parentContentContext.changeSubcontent("Wifi", "quick_settings/WifiSettings.qml", {
                        parentContentContext: root.parentContentContext
                    })
                    root.parentContentContext.isInSubcontent = true
                }
            }
            OptionButtonWithExtra {
                Layout.fillWidth: true
                Layout.preferredHeight: buttonsGrid.childrenHeight

                displayIcon: ""

                Binding on toggleState {
                    value: SystemStates.wifiEnabled
                }
                onPrimaryClick: SystemStates.wifiEnabled = !SystemStates.wifiEnabled
                onSecondaryClick: {
                    root.parentContentContext.changeSubcontent("Bluetooth", "quick_settings/BluetoothSettings.qml", {
                    })
                    root.parentContentContext.isInSubcontent = true
                }

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
        width: root.width

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
