import Quickshell
import QtQuick
import "../commons/"
import "../vars/"

FullScreenPanel {
    visibleBy: PopupStates.showPowerPopup
    toggleVisible: PopupStates.toggleShowPowerPopup
}
