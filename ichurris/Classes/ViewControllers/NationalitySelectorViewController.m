//
//  NationalitySelectorViewController.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MySexSelectorViewController.h"
#import "NationalitySelectorViewController.h"
#import "NSUserDefaultsManager.h"

@interface  NationalitySelectorViewController ( Private )
- (void)saveIntoNSUD:(NSString*)nationality;
@end

#pragma mark -

@implementation NationalitySelectorViewController

@synthesize spanishButton;
@synthesize foreignButton;

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
	[self.navigationItem setTitle:@"Nacionalidad"];
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
    [super dealloc];
}

#pragma mark Public

- (IBAction) spanishButtonPressed:(id)sender {
	[self saveIntoNSUD:@"spanish"];
	MySexSelectorViewController *masvc = [[MySexSelectorViewController alloc] initWithNibName:@"MySexSelectorViewController" bundle:nil];
	[[self navigationController] pushViewController:masvc animated:YES];
	[masvc release];
}

- (IBAction) foreignButtonPressed:(id)sender {
	[self saveIntoNSUD:@"foreign"];
	MySexSelectorViewController *masvc = [[MySexSelectorViewController alloc] initWithNibName:@"MySexSelectorViewController" bundle:nil];
	[[self navigationController] pushViewController:masvc animated:YES];
	[masvc release];
}


#pragma mark -
#pragma mark Private

- (void)saveIntoNSUD:(NSString*)nationality {
	[[NSUserDefaultsManager sharedInstance] saveToUserDefaults:nationality key:kUDDesiredNationality];
}

@end
