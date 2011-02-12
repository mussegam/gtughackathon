//
//  Town.h
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
<<<<<<< HEAD
#import "MyCLController.h"
=======
#import <CoreLocation/CoreLocation.h>
>>>>>>> 4960720588795c8de67ab0059fd3158ea4742192

@interface Town : NSObject {
	NSString *name;
	double lat;
	double lon;
	double distance;
	NSUInteger male0a14;
	NSUInteger male15a64;
	NSUInteger male65a84;
	NSUInteger male85;
	NSUInteger female0a14;
	NSUInteger female15a64;
	NSUInteger female65a84;
	NSUInteger female85;
	NSUInteger total;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@property (nonatomic, assign, getter=getDistanceTo) double distance;
@property (nonatomic, assign) NSUInteger male0a14;
@property (nonatomic, assign) NSUInteger male15a64;
@property (nonatomic, assign) NSUInteger male65a84;
@property (nonatomic, assign) NSUInteger male85;
@property (nonatomic, assign) NSUInteger female0a14;
@property (nonatomic, assign) NSUInteger female15a64;
@property (nonatomic, assign) NSUInteger female65a84;
@property (nonatomic, assign) NSUInteger female85;	
@property (nonatomic, assign) NSUInteger total;

- (double)getDistanceFrom:(CLLocation*)aCoord;
- (NSUInteger)getTotalMale;
- (NSUInteger)getTotalFemale;
- (NSUInteger)getGetCachoProbability;

+ (NSArray *)fetchNearTowns;

@end
