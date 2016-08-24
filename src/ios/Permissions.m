#import "Permissions.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <EventKit/EventKit.h>
#import <Cordova/CDV.h>

@implementation Permissions

- (void)getLocationPermissions:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[self updateLocationPermissions]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getNotificationPermissions:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[self updateNotificationPermissions]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getCalendarPermissions:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[self updateCalendarPermissions]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void)askPermission:(CDVInvokedUrlCommand*)command {
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:[self askPermissionFor]];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (CDVCommandStatus)askPermissionFor {
    return CDVCommandStatus_OK;
}

-(BOOL)updateLocationPermissions{
    BOOL result = false;
    if([CLLocationManager significantLocationChangeMonitoringAvailable] == NO){
        
    } else {        
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
            result = true;
        } else if(status == kCLAuthorizationStatusAuthorizedAlways){
            result = true;
        } else if(status == kCLAuthorizationStatusNotDetermined) {
        } else if(status == kCLAuthorizationStatusDenied) {
        } else if(status == kCLAuthorizationStatusRestricted) {
        }
    }
    return result;
}

-(BOOL)updateNotificationPermissions{
    BOOL result = false;
    UIUserNotificationSettings *settings = [UIApplication sharedApplication].currentUserNotificationSettings;
    if(settings.types != UIUserNotificationTypeNone){
        result = true;
    }
    return result;
}

-(BOOL)updateCalendarPermissions{
    BOOL result = false;
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if(status == EKAuthorizationStatusNotDetermined){
    } else if(status == EKAuthorizationStatusAuthorized){
        result = true;
    } else if(status == EKAuthorizationStatusDenied){
    } else if(status == EKAuthorizationStatusRestricted){
    }
    return result;
}

@end

