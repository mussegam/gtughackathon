//
//  TownViewController.h
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TownViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	NSMutableArray *towns;
	UITableView *myTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;

@end
