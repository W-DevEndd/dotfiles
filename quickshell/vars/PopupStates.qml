pragma Singleton
import QtQuick

QtObject {

    readonly property var popupIsShowed: showSystemPopup || showPowerPopup

    // PowerPopup
    property var showPowerPopup: false
    function toggleShowPowerPopup() { showPowerPopup = !showPowerPopup }

    // SystemPopup
    property var showSystemPopup: false
    function toggleShowSystemPopup() { showSystemPopup = !showSystemPopup }
}
