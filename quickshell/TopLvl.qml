pragma Singleton
import QtQuick
import Quickshell.Wayland

QtObject {
    property var isFullScreen: ToplevelManager.activeToplevel ? ToplevelManager.activeToplevel.fullscreen : false
}
