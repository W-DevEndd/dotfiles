import QtQuick
import "../vars/"

Text {
    color: Styles.textColor
    font.pointSize: Styles.fontSize

    Component.onCompleted: { color.a = Styles.componentAlpha}
}
