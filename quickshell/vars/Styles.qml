pragma Singleton
import QtQuick
import "../commons/"

QtObject {

    // All components
    property real componentAlpha: 1

    // Shell BG
    property color bgColor: CatppuccinMocha.base
    property real bgAlpha: 0.1 * componentAlpha
    property int bgBorderW: 0
    property color bgBorderColor: "black"

    // Texts
    property int fontSize: 11
    property color textColor: CatppuccinMocha.text
    property color textColor2: CatppuccinMocha.overlay1
    property color textColor3: bgColor
    property int fontWeight: 32

    // Topbar
    property int topbarWidth: 28
}
