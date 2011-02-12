//
//  Town.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <stdlib.h>
#import "MyCLController.h"
#import "Town.h"
#import "FMDatabase.h"
#import "NSUserDefaultsManager.h"

@implementation Town

@synthesize name, lat, lon, distance;
@synthesize male0a14, male15a64, male65a84, male85;
@synthesize female0a14, female15a64, female65a84, female85, total;	

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
        distance = 100;
		total = 0;
	}
	return self;
}


- (void) dealloc
{
	self.name = nil;
	[super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name:%@ Lat:%f Lon:%f Males:%d Females:%d Distance:%f",self.name, self.lat, self.lon, [self getTotalMale], [self getTotalFemale], self.distance];
}

#pragma mark -
#pragma mark Public

- (double)getDistanceFrom:(CLLocation*)aCoord {
	return 0;
}

- (NSUInteger)getTotal {
	return [self getTotalMale]+[self getTotalFemale];
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
        
        town.distance = [location distanceFromLocation:[[CLLocation alloc] initWithLatitude:town.lat longitude:town.lon]];
        
        [results addObject:town];
        [town release];
    }
    
    [db close];
    
    NSArray *outArray = [NSArray arrayWithArray:results];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES] autorelease];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    outArray = [outArray sortedArrayUsingDescriptors:sortDescriptors];
    
    NSLog(@"Towns: %d",[outArray count]);
    
    [results release];
    return outArray;
}

- (NSUInteger)getGetCachoProbability {
	NSString *desiredSex = [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDDesiredSex];
	NSNumber *desiredAge = [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDDesiredAge];
	NSString *desiredNat = [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDDesiredNationality];
	NSString *mySex		 = [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDMySex];
	NSNumber *myAge		 = [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDMyAge];
	NSNumber *mySalary	 = [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDMySalary];
	
	NSArray *salaries = [NSArray arrayWithObjects:
						 [NSNumber numberWithInt:0],
						 [NSNumber numberWithInt:12000],
						 [NSNumber numberWithInt:18000],
						 [NSNumber numberWithInt:25000],
						 [NSNumber numberWithInt:36000],
						 [NSNumber numberWithInt:50000],
						 [NSNumber numberWithInt:100000],
						 [NSNumber numberWithInt:250000],nil];
	
	NSArray *salariesMapPoints = [NSArray arrayWithObjects:
								  [NSNumber numberWithFloat:4],
								  [NSNumber numberWithFloat:5],
								  [NSNumber numberWithFloat:6],
								  [NSNumber numberWithFloat:7],
								  [NSNumber numberWithFloat:8],
								  [NSNumber numberWithFloat:9],
								  [NSNumber numberWithFloat:9.5],
								  [NSNumber numberWithFloat:10],nil];
	
	NSUInteger salaryIdx = [salaries indexOfObject:mySalary];
	float salaryPoints = [[salariesMapPoints objectAtIndex:salaryIdx] floatValue];	// 4-10 points

	
	NSArray *ages = [NSArray arrayWithObjects:
					 [NSNumber numberWithInt:0],
					 [NSNumber numberWithInt:15],
					 [NSNumber numberWithInt:19],
					 [NSNumber numberWithInt:26],
					 [NSNumber numberWithInt:33],
					 [NSNumber numberWithInt:46],
					 [NSNumber numberWithInt:61],
					 [NSNumber numberWithInt:71],
					 [NSNumber numberWithInt:85],nil];
	
	NSArray *agesMapAmount;
	if (desiredSex && [desiredSex isEqualToString:@"female"]) {
		agesMapAmount = [NSArray arrayWithObjects:
						 [NSNumber numberWithUnsignedInt:female0a14],
						 [NSNumber numberWithUnsignedInt:female0a14],
						 [NSNumber numberWithUnsignedInt:female15a64],
						 [NSNumber numberWithUnsignedInt:female15a64],
						 [NSNumber numberWithUnsignedInt:female15a64],
						 [NSNumber numberWithUnsignedInt:female15a64],
						 [NSNumber numberWithUnsignedInt:female65a84],
						 [NSNumber numberWithUnsignedInt:female65a84],
						 [NSNumber numberWithUnsignedInt:female85],nil];
	}
	else {
		agesMapAmount = [NSArray arrayWithObjects:
						 [NSNumber numberWithUnsignedInt:male0a14],
						 [NSNumber numberWithUnsignedInt:male0a14],
						 [NSNumber numberWithUnsignedInt:male15a64],
						 [NSNumber numberWithUnsignedInt:male15a64],
						 [NSNumber numberWithUnsignedInt:male15a64],
						 [NSNumber numberWithUnsignedInt:male15a64],
						 [NSNumber numberWithUnsignedInt:male65a84],
						 [NSNumber numberWithUnsignedInt:male65a84],
						 [NSNumber numberWithUnsignedInt:male85],nil];
	}

	NSUInteger ageIdx = [ages indexOfObject:myAge];
	NSNumber *numberPeople = [agesMapAmount objectAtIndex:ageIdx];
	
	NSUInteger ntotal = [self getTotal];
	float agePoints = ((float)[numberPeople intValue]*10)/ntotal;
	
	float results = salaryPoints*agePoints;

	if (mySex == desiredSex) results =- 10;	// Homesexuality moustache penalty
	results -= ([myAge intValue] - [desiredAge intValue]) / 2;	// Asaltacunas bonus/malus
	
	// Niquelator
	if (results<10) results = 10;	
	return (NSUInteger)results+(arc4random() % 10);
;
}

@end
