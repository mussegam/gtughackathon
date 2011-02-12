//
//  NSUserDefaultsManager.h
//  IESE
//
//  Created by Albert Hernández on 08/09/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUDDesiredSex @"dSex"
#define kUDDesiredAge @"dAge"
#define kUDDesiredNationality @"dNationality"
#define kUDMySex @"mSex"
#define kUDMyAge @"mAge"
#define kUDMySalary @"mSalary"

@class Curso;

@interface NSUserDefaultsManager : NSObject {
	
}

+ (NSUserDefaultsManager*)sharedInstance;


#pragma mark -
#pragma mark Public Methods

- (void)saveToUserDefaults:(id)value key:(NSString*)aKey;
- (id)retrieveFromUserDefaults:(NSString*)aKey;
- (void)deleteFromUserDefaults:(NSString*)aKey;

@end