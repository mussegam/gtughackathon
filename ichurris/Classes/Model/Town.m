//
//  Town.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyCLController.h"
#import "Town.h"
#import "FMDatabase.h"

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

- (NSString *)description {
    return [NSString stringWithFormat:@"Name:%@ Lat:%f Lon:%f Males:%d Females:%d",self.name, self.lat, self.lon, [self getTotalMale], [self getTotalFemale]];
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

+ (NSArray *)fetchNearTowns {
    CLLocation *location = [[MyCLController sharedInstance] bestEffortAtLocation];
    float latitude = location.coordinate.latitude;
    float longitude = location.coordinate.longitude;
    float factor = 0.1;
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"towns" ofType:@"db"];
    FMDatabase* db = [FMDatabase databaseWithPath:path];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSString *query = @"select name,lat,lon,home0,home1,home2,home3,dona0,dona1,dona2,dona3 from towns";
    NSString *where = [NSString stringWithFormat:@" where lat>%f AND lat<=%f AND lon>%f AND lon<=%f",latitude-factor,latitude+factor,longitude-factor,longitude+factor];
    query = [query stringByAppendingString:where];
    NSLog(@"query: %@",query);
    
    FMResultSet *rs = [db executeQuery:query];
    while ([rs next]) {
        Town *town = [[Town alloc] init];
        town.name = [rs stringForColumnIndex:0];
        town.lat = [rs doubleForColumnIndex:1];
		town.lon = [rs doubleForColumnIndex:2];
		town.male0a14 = [rs intForColumnIndex:3];
		town.male15a64 = [rs intForColumnIndex:4];
		town.male65a84 = [rs intForColumnIndex:5];
		town.male85 = [rs intForColumnIndex:6];
		town.female0a14 = [rs intForColumnIndex:7];
		town.female15a64 = [rs intForColumnIndex:8];
		town.female65a84 = [rs intForColumnIndex:9];
		town.female85 = [rs intForColumnIndex:10];
        
        [results addObject:town];
        [town release];
    }
    
    [db close];
    
    NSArray *outArray = [NSArray arrayWithArray:results];
    [results release];
    return outArray;
}

@end
