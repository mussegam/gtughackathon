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
    [self.navigationItem setTitle:@"ChurriMap"];
	
    ichurrisAppDelegate *dele = [[UIApplication sharedApplication] delegate];
    self.towns = [dele nearTowns];
	[mapaView setRegion:MKCoordinateRegionMakeWithDistance([dele bestLocation].coordinate, 25000, 25000)];
    
    for (Town *town in towns) {
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(town.lat, town.lon) radius:([town getGetCachoProbability]+10)*100];
        [mapaView addOverlay:circle];
    }
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

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
    MKCircleView *circleView = [[[MKCircleView alloc] initWithCircle:overlay] autorelease];
    circleView.lineWidth = 1.0;
    circleView.strokeColor = [UIColor redColor];
    return circleView;
}

@end