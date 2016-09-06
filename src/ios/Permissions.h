#import <Cordova/CDVPlugin.h>
#import <HealthKit/HealthKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Permissions : CDVPlugin

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) HKHealthStore *healthStore;

- (void)getPermissions:(CDVInvokedUrlCommand*)command;

- (void)getLocationPermissions:(CDVInvokedUrlCommand*)command;

- (void)getNotificationPermissions:(CDVInvokedUrlCommand*)command;

- (void)getHealthKitPermissions:(CDVInvokedUrlCommand*)command;

- (void)getCalendarPermissions:(CDVInvokedUrlCommand*)command;

- (void)openSettings:(CDVInvokedUrlCommand*)command;


@end
