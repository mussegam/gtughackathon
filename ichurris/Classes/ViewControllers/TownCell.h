//
//  TownCell.h
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TownCell : UITableViewCell {
	UIImageView *thumbnailImage;
	UILabel *townName;
}

@property (nonatomic, retain) IBOutlet UIImageView *thumbnailImage;
@property (nonatomic, retain) IBOutlet UILabel *townName;

@end
