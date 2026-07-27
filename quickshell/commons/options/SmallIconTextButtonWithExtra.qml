import QtQuick
import "root:/"
import "./"

Row {
    id: root

    property string displayIcon: "#"
    property string displayText: "Aaaaaa"
    property string displayExtraIcon: ""

    property color contentColor: Catppuccin.text
    property color bgColor: Catppuccin.surface0
    property color bgColorHovered: Catppuccin.surface1

    signal clicked()
    signal secondaryClicked()

    width: childrenRect.width
    spacing: 2

    SmallIconTextButton {
        height: root.height

        displayText: root.displayText
        displayIcon: root.displayIcon

        contentColor: root.contentColor
        bgColor: hover1.hovered ? root.bgColorHovered: root.bgColor

        onClicked: root.clicked()
        HoverHandler { id: hover1; cursorShape: Qt.PointingHandCursor }
    }
    SmallIconButton {
        height: root.height
        width: height

        displayIcon: root.displayExtraIcon

        iconColor: root.contentColor
        bgColor: hover2.hovered ? root.bgColorHovered: root.bgColor

        onClicked: root.secondaryClicked()
        HoverHandler { id: hover2; cursorShape: Qt.PointingHandCursor }
    }
}
