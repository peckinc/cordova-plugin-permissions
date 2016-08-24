cordova.define("cordova-plugin-permissions.Permissions", function(require, exports, module) { "use strict";
    
    function Permissions() {
    }

    Permissions.prototype.getLocationPermissions = function (callback) {
        cordova.exec(callback, null, "Permissions", "getLocationPermissions", []);
    };

    Permissions.prototype.getNotificationPermissions = function (callback) {
        cordova.exec(callback, null, "Permissions", "getNotificationPermissions", []);
    };

    Permissions.prototype.getCalendarPermissions = function (callback) {
        cordova.exec(callback, null, "Permissions", "getCalendarPermissions", []);
    };

    Permissions.prototype.askPermission = function (key, callback) {
      cordova.exec(callback, null, "Permissions", "askPermission", []);
    };

    Permissions.install = function () {
      if (!window.plugins) {
        window.plugins = {};
      }

      window.plugins.permissions = new Permissions();
      return window.plugins.permissions;
    };

    cordova.addConstructor(Permissions.install);

});
