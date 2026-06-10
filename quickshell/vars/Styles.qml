pragma Singleton
import QtQuick
import "../commons/"

QtObject {

    // WM
    property int windowGaps: 5
    // All components
    property real componentAlpha: 1
    property real cornerRadius1: 10
    property real cornerRadius2: 20

    // Shell BG
    property color bgColor: CatppuccinMocha.base
    property color bgColor1: CatppuccinMocha.crust
    property real bgAlpha: 0.85 * componentAlpha
    property int bgBorderW: 1
    property color bgBorderColor: CatppuccinMocha.crust
    property color bgBorderColor1: CatppuccinMocha.surface0

    // Texts, Content
    property color prime: CatppuccinMocha.lavender
    property int fontSize: 11
    property int h1FontSize: 16
    property color textColor: CatppuccinMocha.text
    property color textColor2: CatppuccinMocha.overlay1
    property color textColor3: bgColor
    property int fontWeight: 32

    // Topbar
    property int topbarWidth: 28
}
