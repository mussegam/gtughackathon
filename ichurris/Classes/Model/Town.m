//
//  Town.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Town.h"
#import "FMDatabase.h"

@implementation Town

@synthesize name, lat, lon;
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

- (NSUInteger)getTotalMale {
	return male0a14 + male15a64 + male65a84 + male85;
}

- (NSUInteger)getTotalFemale {
	return female0a14 + female15a64 + female65a84 + female85;
}

+ (NSArray *)fetchNearTowns {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"towns" ofType:@"db"];
    FMDatabase* db = [FMDatabase databaseWithPath:path];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSString *query = @"select name,lat,lon,home0,home1,home2,home3,dona0,dona1,dona2,dona3 from towns";
    NSString *where = @"where lat> AND lat<= AND lon> AND lon<=";
    
    FMResultSet *rs = [db executeQuery:query];
    while ([rs next]) {
        NSLog(@"%@",[rs stringForColumnIndex:0]);
    }
    
    [db close];
    
    return [NSArray array];
}

@end
