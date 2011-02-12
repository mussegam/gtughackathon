//
//  ResultsViewController.h
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResultsViewController : UIViewController {
	UILabel *adjectiveLabel;
	UILabel *resultLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *adjectiveLabel;
@property (nonatomic, retain) IBOutlet UILabel *resultLabel;

- (IBAction)empezarButtonPressed:(id)sender;

@end
