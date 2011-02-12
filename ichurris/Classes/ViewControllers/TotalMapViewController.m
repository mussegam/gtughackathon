//
//  TotalMapViewController.m
//  ichurris
//
//  Created by Javier Dolcet on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TotalMapViewController.h"
#import "ichurrisAppDelegate.h"
#import "Town.h"

@implementation TotalMapViewController

@synthesize mapaView,towns;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ichurrisAppDelegate *dele = [[UIApplication sharedApplication] delegate];
    self.towns = [dele nearTowns];
    [mapaView setCenterCoordinate:[dele bestLocation].coordinate];
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
    [mapaView release];
    [towns release];
    [super dealloc];
}


@end
