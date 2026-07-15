import QtQuick
import "./"

Item {
    id: root

    property var toggleState: false

    property int spacing: 1 

    property string displayExtraIcon: ""
    property string displayIcon: "$"

    signal primaryClick()
    signal secondaryClick()

    OptionButton {
        width: root.width * 0.7 - (spacing / 2)
        height: root.height
        anchors.left: root.left

        displayIcon: root.displayIcon

        Binding on toggleState {
            value: root.toggleState
        }
        onClicked: root.primaryClick()
    }
    OptionButton {
        width: root.width * 0.3 - (spacing / 2)
        height: root.height
        anchors.right: root.right

        displayIcon: root.displayExtraIcon

        Binding on toggleState {
            value: root.toggleState
        }
        onClicked: root.secondaryClick()
    }
}
