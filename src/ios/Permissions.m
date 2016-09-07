#import "Permissions.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <EventKit/EventKit.h>
#import <HealthKit/HealthKit.h>
#import <Cordova/CDV.h>


@implementation Permissions

NSString* kUnknown = @"unknown";
NSString* kAuthorized = @"authorized";
NSString* kDenied = @"denied";

-(void)pluginInitialize {
    [super pluginInitialize];
    _healthStore = [HKHealthStore new];
}

- (void)getPermissions:(CDVInvokedUrlCommand*)command {

    NSString* location =[self updateLocationPermissions];
    NSString* notification =[self updateNotificationPermissions];
    NSString* health =[self updateHealthKitPermissions];
    NSString* calendar =[self updateCalendarPermissions];

    NSDictionary *jsonDictionary = @{
        @"location" : location,
        @"notification" : notification,
        @"health" : health,
        @"calendar" : calendar
    };

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];

    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:json];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getLocationPermissions:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[self updateLocationPermissions]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getNotificationPermissions:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[self updateNotificationPermissions]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getHealthKitPermissions:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[self updateHealthKitPermissions]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getCalendarPermissions:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[self updateCalendarPermissions]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(NSString*)updateLocationPermissions{
    NSString* result = kUnknown;
    if([CLLocationManager significantLocationChangeMonitoringAvailable] == NO){

    } else {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
            result = kAuthorized;
        } else if(status == kCLAuthorizationStatusAuthorizedAlways){
            result = kAuthorized;
        } else if(status == kCLAuthorizationStatusNotDetermined) {
        } else if(status == kCLAuthorizationStatusDenied) {
            result = kDenied;
       } else if(status == kCLAuthorizationStatusRestricted) {
            result = kDenied;
        }
    }
    return result;
}

// note there is no kUnknown for notifications
-(NSString*)updateNotificationPermissions{
    NSString* result = kDenied;
    UIUserNotificationSettings *settings = [UIApplication sharedApplication].currentUserNotificationSettings;
    if(settings.types != UIUserNotificationTypeNone){
        result = kAuthorized;
    }
    return result;
}

-(NSString*)updateHealthKitPermissions{
    NSString* result = kUnknown;
    HKObjectType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:type];
    if (status == HKAuthorizationStatusNotDetermined) {
    } else if (status == HKAuthorizationStatusSharingAuthorized) {
        result = kAuthorized;
    } else if (status == HKAuthorizationStatusSharingDenied) {
        result = kDenied;
    }
    return result;
}

-(NSString*)updateCalendarPermissions{
    NSString* result = kUnknown;
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if(status == EKAuthorizationStatusNotDetermined){
    } else if(status == EKAuthorizationStatusAuthorized){
        result = kAuthorized;
    } else if(status == EKAuthorizationStatusDenied){
        result = kDenied;
    } else if(status == EKAuthorizationStatusRestricted){
        result = kDenied;
    }
    return result;
}

- (void)openSettings:(CDVInvokedUrlCommand*)command {

    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:appSettings];

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


@end
