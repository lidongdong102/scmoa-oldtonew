cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
                  {
                  "id": "cl.kunder.webview.webview",
                  "file": "plugins/cl.kunder.webview/www/webViewPlugin.js",
                  "pluginId": "cl.kunder.webview",
                  "merges": [
                             "webview"
                             ]
                  },
    {
        "file": "plugins/org.apache.cordova.inappbrowser/www/InAppBrowser.js",
        "id": "org.apache.cordova.inappbrowser.InAppBrowser",
        "clobbers": [
            "window.open"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.device/www/device.js",
        "id": "org.apache.cordova.device.device",
        "clobbers": [
            "device"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.dialogs/www/notification.js",
        "id": "org.apache.cordova.dialogs.notification",
        "merges": [
            "navigator.notification"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.vibration/www/vibration.js",
        "id": "org.apache.cordova.vibration.notification",
        "merges": [
            "navigator.notification"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.network-information/www/network.js",
        "id": "org.apache.cordova.network-information.network",
        "clobbers": [
            "navigator.connection",
            "navigator.network.connection"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.network-information/www/Connection.js",
        "id": "org.apache.cordova.network-information.Connection",
        "clobbers": [
            "Connection"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "org.apache.cordova.inappbrowser": "0.3.1",
    "org.apache.cordova.device": "0.2.8",
    "org.apache.cordova.dialogs": "0.2.6",
    "org.apache.cordova.vibration": "0.3.7",
    "org.apache.cordova.network-information": "0.2.7"
}
// BOTTOM OF METADATA
});