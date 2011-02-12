//
//  MyAgeSelectorViewController.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyAgeSelectorViewController.h"
#import "MySalaryViewController.h"
#import "NSUserDefaultsManager.h"

@interface MyAgeSelectorViewController ( Private )
- (void)saveIntoNSUD:(NSNumber*)age;
@end

#pragma mark -

@implementation MyAgeSelectorViewController

@synthesize agePicker, selectButton;

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
	[self.navigationItem setTitle:@"¿Y tú edad?"];
	labels = [[NSArray arrayWithObjects:
			   @"0-14",@"15-18",@"19-25",@"26-32",@"33-45",@"46-60",@"61-70",@"71-84",@"+85",nil] 
			  retain];
	values = [[NSArray arrayWithObjects:
			   [NSNumber numberWithInt:0],
			   [NSNumber numberWithInt:15],
			   [NSNumber numberWithInt:19],
			   [NSNumber numberWithInt:26],
			   [NSNumber numberWithInt:33],
			   [NSNumber numberWithInt:46],
			   [NSNumber numberWithInt:61],
			   [NSNumber numberWithInt:71],
			   [NSNumber numberWithInt:85],nil] 
			  retain];
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
	[labels release];
	[values release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (IBAction)selectButtonPressed:(id)sender {
	NSNumber *age = [values objectAtIndex:[agePicker selectedRowInComponent:0]];
	[self saveIntoNSUD:age];
	MySalaryViewController *msvc = [[MySalaryViewController alloc] initWithNibName:@"MySalaryViewController" bundle:nil];
	[[self navigationController] pushViewController:msvc animated:YES];
	[msvc release];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	NSInteger count = 0;
	if (pickerView == agePicker) {
		count = 1;
	}
	return count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSInteger rowCount = 0;
	if (pickerView == agePicker) {
		rowCount = [values count];
	}	
	return rowCount;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSString *label = @"";
	if (pickerView == agePicker) {
		label = [labels objectAtIndex:row];
	}
	return label;
}


#pragma mark -
#pragma mark Private

- (void)saveIntoNSUD:(NSNumber*)age {
	[[NSUserDefaultsManager sharedInstance] saveToUserDefaults:age key:kUDMyAge];
}

@end
