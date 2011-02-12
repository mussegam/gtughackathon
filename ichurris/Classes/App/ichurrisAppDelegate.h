//
//  ichurrisAppDelegate.h
//  ichurris
//
//  Created by Javier Dolcet on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCLController.h"

@interface ichurrisAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
    NSArray *nearTowns;
    CLLocation *bestLocation;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSArray *nearTowns;
@property (nonatomic, retain) CLLocation *bestLocation;

@end