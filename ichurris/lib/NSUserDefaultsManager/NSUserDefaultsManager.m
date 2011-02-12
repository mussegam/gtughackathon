//
//  NSUserDefaultsManager.m
//  IESE
//
//  Created by Albert Hernández on 08/09/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "NSUserDefaultsManager.h"
#import "Defines.h"

@interface NSUserDefaultsManager ()

- (void)saveToUserDefaults:(id)value key:(NSString*)aKey;
- (id)retrieveFromUserDefaults:(NSString*)aKey;
- (void)deleteFromUserDefaults:(NSString*)aKey;

@end

#pragma mark -

@implementation NSUserDefaultsManager

// This is a singleton class, see below
static NSUserDefaultsManager *sharedNSUDMDelegate = nil;

#pragma mark -
#pragma mark Public Methods

- (void)saveToUserDefaults:(id)value key:(NSString*)aKey
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults)
	{
		if (value != nil)
		{
			id oldval = [standardUserDefaults objectForKey:aKey];
			if (oldval != nil)	// Remove the old value
				[standardUserDefaults removeObjectForKey:aKey];
			
			[standardUserDefaults setObject:value forKey:aKey];
			[standardUserDefaults synchronize];
		}
		else
			DLog(@"Warning: Key '%@' not updated because the value is nil.",aKey);
	}
	else
		DLog(@"Warning: standardUserDefaults couldn't be loaded.");
}

- (id)retrieveFromUserDefaults:(NSString*)aKey
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	id val = nil;
	
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:aKey];
	else
		DLog(@"Warning: standardUserDefaults couldn't be retrieved.");
	
	return val;
}

- (void)deleteFromUserDefaults:(NSString*)aKey
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults)
		[standardUserDefaults removeObjectForKey:aKey];
	else
		DLog(@"Util - deleteFromUserDefaults: no se pudo obtener standardUserDefaults");
}

#pragma mark -
#pragma mark Singleton

// See "Creating a Singleton Instance" in the Cocoa Fundamentals Guide for more info
// http://developer.apple.com/documentation/Cocoa/Conceptual/CocoaFundamentals/CocoaObjects/chapter_3_section_10.html

+ (NSUserDefaultsManager*)sharedInstance
{	
	@synchronized(self)
	{
		if (sharedNSUDMDelegate == nil)
			sharedNSUDMDelegate = [[self alloc] init]; // assignment not done here
	}
	return sharedNSUDMDelegate;
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self) 
	{
		if (sharedNSUDMDelegate == nil)
		{
			sharedNSUDMDelegate = [super allocWithZone:zone];
			return sharedNSUDMDelegate;  // assignment and return on first allocation
		}
	}
	return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (id)retain
{
	return self;
}

- (unsigned)retainCount
{
	return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release
{
	//do nothing
}

- (id)autorelease
{
	return self;
}

@end