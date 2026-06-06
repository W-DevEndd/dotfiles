pragma Singleton
import QtQuick

QtObject {
    property var showPowerPopup: false
    function toggleShowPowerPopup() { showPowerPopup = !showPowerPopup }
    onShowPowerPopupChanged: console.log(showPowerPopup)
}
