import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import "root:/"
import "root:/commons/options/"

OptionSlider {
    id: root
    width: sliderPanel.width

    property real displayValue: sliderPos * 100 + 0.5 | 0

}

