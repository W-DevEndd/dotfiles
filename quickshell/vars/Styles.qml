pragma Singleton
import QtQuick
import "../commons/"

QtObject {

    // All components
    property real componentAlpha: 0.9

    // Shell BG
    property color bgColor: CatppuccinMocha.crust
    property real bgAlpha: 0.5 * componentAlpha
    property int bgBorderW: 0
    property color bgBorderColor: "black"

    // Texts
    property int fontSize: 11
    property color textColor: CatppuccinMocha.text
    property color textColor2: CatppuccinMocha.overlay1
    property color textColor3: bgColor

    // Topbar
    property int topbarWidth: 28
}
