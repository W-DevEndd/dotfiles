import Quickshell

PanelWindow {
    id: root

    property int direction: 2
    width: mainPopup.width
    height: mainPopup.height

    exclusionMode: ExclusionMode.Ignore
    color: "#11ffffff"

    PopupWindow {
        id: mainPopup
        width: 100
        height: 100
    }
}
