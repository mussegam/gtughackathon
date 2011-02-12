//
//  MySexSelectorViewController.h
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MySexSelectorViewController : UIViewController {
	UILabel *titleLabel;
	UIButton *maleButton;
	UIButton *femaleButton;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIButton *maleButton;
@property (nonatomic, retain) IBOutlet UIButton *femaleButton;

- (IBAction)maleButtonPressed:(id)sender;
- (IBAction)femaleButtonPressed:(id)sender;


@end
