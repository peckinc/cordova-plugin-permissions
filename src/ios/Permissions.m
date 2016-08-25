#import "Permissions.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <EventKit/EventKit.h>
#import <HealthKit/HealthKit.h>
#import <Cordova/CDV.h>


@implementation Permissions

-(void)pluginInitialize {
    [super pluginInitialize];
    _healthStore = [HKHealthStore new];
}

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

- (void)getHealthKitPermissions:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[self updateHealthKitPermissions]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
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

-(BOOL)updateHealthKitPermissions{
    BOOL result = false;
    HKObjectType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:type];
    if (status == HKAuthorizationStatusNotDetermined) {
    } else if (status == HKAuthorizationStatusSharingDenied) {
    } else if (status == HKAuthorizationStatusSharingAuthorized) {
        result = true;
    }
    return result;
}

/**
    asks
*/
- (void)askLocationPermission:(CDVInvokedUrlCommand*)command {
    [self askLocationPermissions];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)askNotificationPermission:(CDVInvokedUrlCommand*)command {
    [self askNotificationPermissions];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)askgetCalendarPermission:(CDVInvokedUrlCommand*)command {
    [self askLocationPermissions];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)askHealthKitPermission:(CDVInvokedUrlCommand*)command {
    [self askLocationPermissions];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)askLocationPermissions{
    if(self.locationManager == nil){
        self.locationManager = [[CLLocationManager alloc]init];
    }
    [self.commandDelegate runInBackground:^{
        [self.locationManager requestWhenInUseAuthorization];
    }];

}

-(void)askNotificationPermissions{
    [self.commandDelegate runInBackground:^{
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }];
}



@end
