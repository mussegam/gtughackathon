//
//  MySalaryViewController.h
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MySalaryViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *salaryPicker;
	UIButton *selectButton;
	
	NSArray *labels;
	NSArray *values;
}

@property (nonatomic, retain) IBOutlet UIPickerView *salaryPicker;
@property (nonatomic, retain) IBOutlet UIButton *selectButton;

- (IBAction)selectButtonPressed:(id)sender;

@end
