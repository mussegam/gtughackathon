//
//  SexSelectorViewController.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AgeSelectorViewController.h"
#import "Defines.h"
#import "NSUserDefaultsManager.h"
#import "SexSelectorViewController.h"

@interface SexSelectorViewController ( Private )
- (void)saveIntoNSUD:(NSString*)sex;
@end

#pragma mark -

@implementation SexSelectorViewController

@synthesize titleLabel;
@synthesize maleButton;
@synthesize femaleButton;


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
	[self.navigationItem setTitle:@"¿Qué buscas?"];
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

#pragma mark -
#pragma mark Public

- (IBAction)maleButtonPressed:(id)sender {
	[self saveIntoNSUD:@"male"];
	AgeSelectorViewController *ageSelectorVC = [[AgeSelectorViewController alloc] initWithNibName:@"AgeSelectorViewController"
																						   bundle:nil];
	[[self navigationController] pushViewController:ageSelectorVC animated:YES];
	[ageSelectorVC release];
}

- (IBAction)femaleButtonPressed:(id)sender {
	[self saveIntoNSUD:@"female"];
	AgeSelectorViewController *ageSelectorVC = [[AgeSelectorViewController alloc] initWithNibName:@"AgeSelectorViewController"
																						bundle:nil];
	[[self navigationController] pushViewController:ageSelectorVC animated:YES];
	[ageSelectorVC release];
}

#pragma mark -
#pragma mark Private

- (void)saveIntoNSUD:(NSString*)sex {
	[[NSUserDefaultsManager sharedInstance] saveToUserDefaults:sex key:kUDDesiredSex];
}

@end
