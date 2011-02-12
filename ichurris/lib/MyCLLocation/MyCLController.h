/*
 
 File: MyCLController.h
 Abstract: Singleton class used to talk to CoreLocation and send results back to
 the app's view controllers.
 
 */

#import <CoreLocation/CoreLocation.h>

@protocol LocationDataProtocol<NSObject>

@required

- (void) didFailUpdatingLocation;
- (void) timeout:(CLLocation*)res;
- (void) didFinishUpdatingLocation:(CLLocation*)res;

@optional

- (void) didUpdateLocation:(CLLocation*)res;

@end

// Class definition
@interface MyCLController : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
  CLLocation *bestEffortAtLocation;
	id<LocationDataProtocol> delegado;
}

@property (nonatomic, retain) CLLocation *bestEffortAtLocation;
@property (nonatomic, retain) CLLocationManager *locationManager;

+ (MyCLController *)sharedInstance;

/*
 accuracy -> indicar una de las siguientes constantes, mayor precisión implica mayor consumo de batería y tiempo.
        kCLLocationAccuracyBestForNavigation <-- New iOS4
				kCLLocationAccuracyBest
				kCLLocationAccuracyNearestTenMeters
				kCLLocationAccuracyHundredMeters
				kCLLocationAccuracyKilometer
				kCLLocationAccuracyThreeKilometers
 distance -> kCLDistanceFilterNone ó el número de metros que se quiera
 timeout -> tiempo permitido para encontrar la precisión definida
*/
- (void) startUpdates:(CLLocationAccuracy)accuracy
	   distanceFilter:(CLLocationDistance)distance
			  timeout:(double)timeout
			 delegado:(id<LocationDataProtocol>)aDelegado;

- (BOOL) locationEnabledAndAllowed;

@end