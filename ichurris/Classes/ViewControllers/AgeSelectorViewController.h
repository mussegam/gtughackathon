//
//  AgeSelectorViewController.h
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AgeSelectorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *agePicker;
}

@property (nonatomic, retain) UIPickerView *agePicker;

@end
