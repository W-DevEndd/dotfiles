import QtQuick
import Quickshell
import Quickshell.Io
import "root:/"
import "root:/commons/options/"

OptionSlider {
    id: root
    width: sliderPanel.width

    property var clickCommand: []
    property var dragCommand: []

    property real displayValue: sliderPos * 100 + 0.5 | 0

    onSliderMoved: if (root.dragCommand.length) {
        handleSliderMove.running = false
        handleSliderMove.running = true
    }

    handleLeftTextClick: () => root.clickCommand.length && (
        Quickshell.execDetached(root.clickCommand)
    )

    Process {
        id: handleSliderMove
        command: root.dragCommand
        stdout: StdioCollector {
            // onStreamFinished: soundControl.isUpdating = false
        }
    }
}

