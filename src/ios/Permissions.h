#import <Cordova/CDVPlugin.h>
#import <HealthKit/HealthKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Permissions : CDVPlugin

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) HKHealthStore *healthStore;

- (void)getLocationPermissions:(CDVInvokedUrlCommand*)command;

- (void)getNotificationPermissions:(CDVInvokedUrlCommand*)command;

- (void)getCalendarPermissions:(CDVInvokedUrlCommand*)command;

- (void)getHealthKitPermissions:(CDVInvokedUrlCommand*)command;

- (void)openSettings:(CDVInvokedUrlCommand*)command;


@end
