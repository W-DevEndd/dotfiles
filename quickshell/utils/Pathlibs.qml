pragma Singleton
import QtQuick
import Quickshell

QtObject {
    function userResolve(p: string): string {
        let result = ""
        const baseNames = p.split('/')
        const resolvedNames = []
        let isAbsolated = p.startsWith('/');

        for (let i= 0;i <baseNames.length; i++) {
            const baseName = baseNames[i];

            if (i === 0 && baseName === '~' && !isAbsolated) {
                isAbsolated = true
                const home = Quickshell.env("HOME").split('/')
                home.shift()
                for (const n of home) resolvedNames.push(n)
            } else if (baseName === '.' || baseName === '') continue
            else if (baseName === "..") resolvedNames.pop()
            else resolvedNames.push(baseName)
        }

        result = (isAbsolated ? '/' : '') + resolvedNames.join('/');
        return result
    }
}
