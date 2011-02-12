/*
 
 File: MyCLController.m
 Abstract: Singleton class used to talk to CoreLocation and send results back to
 the app's view controllers.
 
 http://developer.apple.com/iphone/library/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/AdvancedFeatures/chapter_11_section_3.html
 
 */

#import "MyCLController.h"

// This is a singleton class, see below
static MyCLController *sharedCLDelegate = nil;

@implementation MyCLController

@synthesize locationManager,bestEffortAtLocation;

- (id) init {
	self = [super init];
	if (self != nil) {
		self.locationManager = [[[CLLocationManager alloc] init] autorelease];
		self.locationManager.delegate = self; // Tells the location manager to send updates to this object
	}
	return self;
}

- (void) startUpdates:(CLLocationAccuracy)accuracy distanceFilter:(CLLocationDistance)distance timeout:(double)timeout delegado:(id<LocationDataProtocol>)aDelegado {
	
	NSLog(@"MYCLController - startUpdates");
	delegado = aDelegado;
	self.bestEffortAtLocation = nil;
	// This is the most important property to set for the manager. It ultimately determines how the manager will
  // attempt to acquire location and thus, the amount of power that will be consumed.
  locationManager.desiredAccuracy = accuracy;
  // When "tracking" the user, the distance filter can be used to control the frequency with which location measurements
  // are delivered by the manager. If the change in distance is less than the filter, a location will not be delivered.
  locationManager.distanceFilter = distance;
  // Once configured, the location manager must be "started".
  [locationManager startUpdatingLocation];	
	[self performSelector:@selector(timeOut) withObject:nil afterDelay:timeout];
	
}

-(void)timeOut{
	NSLog(@"MYCLController - timeOut");
	[delegado timeout:bestEffortAtLocation];
	[locationManager stopUpdatingLocation];
}

- (void)stopLocationUpdate {
	NSLog(@"MYCLController - stopLocationUpdate");
  [locationManager stopUpdatingLocation];
	// we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeOut) object:nil];
}

/*
 * We want to get and store a location measurement that meets the desired accuracy. For this example, we are
 *      going to use horizontal accuracy as the deciding factor. In other cases, you may wish to use vertical
 *      accuracy, or both together.
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
		NSLog(@"MYCLController - didUpdateToLocation");
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    // test the measurement to see if it is more accurate than the previous measurement
    if (bestEffortAtLocation == nil || bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        // store the location as the "best effort"
        self.bestEffortAtLocation = newLocation;
        [delegado didUpdateLocation:newLocation];
        // test the measurement to see if it meets the desired accuracy
        //
        // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue 
        // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of 
        // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
        //
        if (newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
            // we have a measurement that meets our requirements, so we can stop updating the location
            // 
            // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
          //
          [delegado didFinishUpdatingLocation:newLocation];
          [self stopLocationUpdate];            
        }
    }    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a 
    // timeout that will stop the location manager to save power.
    if ([error code] != kCLErrorLocationUnknown) {
      [delegado didFailUpdatingLocation];
      [self stopLocationUpdate];
    }
}

- (BOOL) locationEnabledAndAllowed {
	return [locationManager locationServicesEnabled];
}

#pragma mark ---- singleton object methods ----

// See "Creating a Singleton Instance" in the Cocoa Fundamentals Guide for more info
// http://developer.apple.com/documentation/Cocoa/Conceptual/CocoaFundamentals/CocoaObjects/chapter_3_section_10.html

+ (MyCLController *)sharedInstance {	
	@synchronized(self) {
		if (sharedCLDelegate == nil) {
			sharedCLDelegate = [[self alloc] init]; // assignment not done here
		}
	}
	return sharedCLDelegate;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedCLDelegate == nil) {
			sharedCLDelegate = [super allocWithZone:zone];
			return sharedCLDelegate;  // assignment and return on first allocation
		}
	}
	return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (id)retain {
	return self;
}

- (unsigned)retainCount {
	return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
	//do nothing
}

- (id)autorelease {
	return self;
}

@end
