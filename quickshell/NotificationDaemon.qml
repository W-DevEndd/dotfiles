pragma Singleton
import Quickshell.Services.Notifications 
import QtQuick

NotificationServer {
    bodySupported: true
    imageSupported: true

    onNotification: n => {
        console.log(n.id)
        console.log(n.appIcon)
        console.log(n.appName)
        console.log(n.summary)
        console.log(n.body)
        console.log(n.image)
    }
}
