cordova.define("cordova-plugin-permissions.Permissions", function(require, exports, module) {

function Permissions() {
}

Permissions.prototype.getPermissions = function (callback) {
    cordova.exec(callback, null, "Permissions", "getPermissions", []);
};

Permissions.prototype.getLocationPermissions = function (callback) {
    cordova.exec(callback, null, "Permissions", "getLocationPermissions", []);
};

Permissions.prototype.getNotificationPermissions = function (callback) {
    cordova.exec(callback, null, "Permissions", "getNotificationPermissions", []);
};

Permissions.prototype.getCalendarPermissions = function (callback) {
    cordova.exec(callback, null, "Permissions", "getCalendarPermissions", []);
};

Permissions.prototype.getHealthKitPermissions = function (callback) {
    cordova.exec(callback, null, "Permissions", "getHealthKitPermissions", []);
};

Permissions.prototype.openSettings = function (callback) {
  cordova.exec(callback, null, "Permissions", "openSettings", []);
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
