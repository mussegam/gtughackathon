//
//  Town.h
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Town : NSObject {
	NSString *name;
	double lat;
	double lon;
	NSUInteger male0a14;
	NSUInteger male15a64;
	NSUInteger male65a84;
	NSUInteger male85;
	NSUInteger female0a14;
	NSUInteger female15a64;
	NSUInteger female65a84;
	NSUInteger female85;	
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@property (nonatomic, assign) NSUInteger male0a14;
@property (nonatomic, assign) NSUInteger male15a64;
@property (nonatomic, assign) NSUInteger male65a84;
@property (nonatomic, assign) NSUInteger male85;
@property (nonatomic, assign) NSUInteger female0a14;
@property (nonatomic, assign) NSUInteger female15a64;
@property (nonatomic, assign) NSUInteger female65a84;
@property (nonatomic, assign) NSUInteger female85;	

- (NSUInteger)getTotalMale;
- (NSUInteger)getTotalFemale;

@end
