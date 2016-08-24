#import <Cordova/CDVPlugin.h>

@interface Permissions : CDVPlugin

- (void)getLocationPermissions:(CDVInvokedUrlCommand*)command;
- (void)getNotificationPermissions:(CDVInvokedUrlCommand*)command;
- (void)getCalendarPermissions:(CDVInvokedUrlCommand*)command;

- (void)askPermission:(CDVInvokedUrlCommand*)command;

@end
