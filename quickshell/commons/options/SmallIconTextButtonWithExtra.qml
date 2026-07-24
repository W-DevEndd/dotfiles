import "./"
import QtQuick

Row {
    id: root

    property string displayIcon: "#"
    property string displayText: "Aaaaaa"
    property string displayExtraIcon: ""

    property color contentColor: Catppuccin.text
    property color bgColor: Catppuccin.surface0

    signal clicked()
    signal secondaryClicked()

    width: childrenRect.width
    spacing: 2

    SmallIconTextButton {
        height: root.height

        displayText: root.displayText
        displayIcon: root.displayIcon

        contentColor: root.contentColor
        bgColor: root.bgColor

        onClicked: root.clicked()
    }
    SmallIconButton {
        height: root.height
        width: height

        displayIcon: root.displayExtraIcon

        iconColor: root.contentColor
        bgColor: root.bgColor

        onClicked: root.secondaryClicked()
    }
}
