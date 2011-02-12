//
//  NationalitySelectorViewController.h
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NationalitySelectorViewController : UIViewController {
	IBOutlet UIButton *spanishButton;
	IBOutlet UIButton *foreignButton;
}

@property (nonatomic, retain) IBOutlet UIButton *spanishButton;
@property (nonatomic, retain) IBOutlet UIButton *foreignButton;

- (IBAction) spanishButtonPressed:(id)sender;
- (IBAction) foreignButtonPressed:(id)sender;

@end
