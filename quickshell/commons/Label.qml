import QtQuick
import "../vars/"

Text {
    color: Styles.textColor
    font.pointSize: Styles.fontSize
    // font.bold: true

    Component.onCompleted: { color.a = Styles.componentAlpha}
}
