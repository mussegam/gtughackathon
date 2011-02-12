//
//  TownViewController.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "Defines.h"
#import "Town.h"
#import "TownCell.h"
#import "TownViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ResultsViewController.h"
#import "ichurrisAppDelegate.h"
#import "Town.h"
#import "TotalMapViewController.h"

@implementation TownViewController

@synthesize myTableView, towns;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationItem setTitle:@"¿Para que municipio?"];
    ichurrisAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.towns = [NSMutableArray arrayWithArray:[delegate nearTowns]];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[towns release];
    [super dealloc];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) {
		Town *town = (Town*)[towns objectAtIndex:indexPath.row];
		NSUInteger kk = [town getGetCachoProbability];
        ResultsViewController *rvc = [[ResultsViewController alloc] initWithNibName:@"ResultsViewController" bundle:nil];
        [[self navigationController] pushViewController:rvc animated:YES];
		rvc.resultLabel.text = [NSString stringWithFormat:@"%d/100",[town getGetCachoProbability]];
        [rvc release];
    } else {
        TotalMapViewController *map = [[TotalMapViewController alloc] initWithNibName:@"TotalMapViewController" bundle:nil];
        [[self navigationController] pushViewController:map animated:YES];
        [map release];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	if (section > 0) return 0;
	return [towns count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"TownCell";
    
	TownCell *cell = (TownCell*)[aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil)
    {
		//IB engineer approved
		UIViewController *ctl = [[UIViewController alloc] initWithNibName:@"TownCell" bundle:nil];
		cell = (TownCell*)ctl.view;
		[ctl release];
	}
    
    if (indexPath.row == 0) {
        
        cell.townName.text = @"Mostrar todos";
        
    } else {
        // Cell setup...
        NSURL *url = [NSURL URLWithString:@"http://www.google.es/images/nav_logo36.png"];
        
        __block ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
        [request setDelegate:self];
        [request setCompletionBlock:^{
            NSData *imageData = [request responseData];
            [cell.thumbnailImage setImage:[UIImage imageWithData:imageData]];
        }];
        [request startAsynchronous];
        
        Town *town = [towns objectAtIndex:indexPath.row];
        
        cell.townName.text = town.name;
    }
	
	return cell;
}


@end
