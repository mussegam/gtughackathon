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


@implementation TownViewController

@synthesize myTableView;

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
	towns = [[NSMutableArray alloc] init];
	[towns addObject:@"a"];
	[towns addObject:@"b"];
	[towns addObject:@"c"];
	[towns addObject:@"d"];
	[towns addObject:@"e"];
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
	ResultsViewController *rvc = [[ResultsViewController alloc] initWithNibName:@"ResultsViewController" bundle:nil];
	Town *town = (Town*)[towns objectAtIndex:indexPath.row];
	rvc.resultLabel.text = [NSString stringWithFormat:@"%d",[town getGetCachoProbability]];
	[[self navigationController] pushViewController:rvc animated:YES];
	[rvc release];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	if (section > 0) return 0;
	return [towns count];
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
    
	// Cell setup...
    NSURL *url = [NSURL URLWithString:@"http://www.google.es/images/nav_logo36.png"];
	
	__block ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
	[request setDelegate:self];
	[request setCompletionBlock:^{
		NSData *imageData = [request responseData];
		[cell.thumbnailImage setImage:[UIImage imageWithData:imageData]];
	}];
	[request startAsynchronous];
	
	cell.townName.text = @"Basalona";
	
	return cell;
}


@end
