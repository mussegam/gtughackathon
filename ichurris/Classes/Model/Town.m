//
//  Town.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyCLController.h"
#import "Town.h"


@implementation Town

@synthesize name, lat, lon, distance;
@synthesize male0a14, male15a64, male65a84, male85;
@synthesize female0a14, female15a64, female65a84, female85;	

- (id) init {
	self = [super init];
	if (self != nil) {
		name = [[NSString alloc] init];
		lat = 0.01;
		lon = 0.01;
		male0a14 = 0;
		male15a64 = 0;
		male65a84 = 0;
		male85 = 0;
		female0a14 = 0;
		female15a64 = 0;
		female65a84 = 0;
		female85 = 0;	
	}
	return self;
}


- (void) dealloc
{
	self.name = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Public

- (double)getDistanceFrom:(CLLocation*)aCoord {
	return 0;
}

- (NSUInteger)getTotalMale {
	return male0a14 + male15a64 + male65a84 + male85;
}

- (NSUInteger)getTotalFemale {
	return female0a14 + female15a64 + female65a84 + female85;
}

@end