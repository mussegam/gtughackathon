//
//  TownCell.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TownCell.h"


@implementation TownCell

@synthesize thumbnailImage, townName;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
	if (selected) [super setSelected:NO animated:YES];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
