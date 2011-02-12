//
//  MySalaryViewController.m
//  ichurris
//
//  Created by Albert Hernández López on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Defines.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "MySalaryViewController.h"
#import "NSUserDefaultsManager.h"

@interface  MySalaryViewController ( Private )
- (void)saveIntoNSUD:(NSNumber*)salary;
@end

#pragma mark -

@implementation MySalaryViewController

@synthesize salaryPicker, selectButton;

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
	[self.navigationItem setTitle:@"¿Cual es tu salario?"];
	labels = [[NSArray arrayWithObjects:
			   @"0-12000€/año",@"12000-18000€/año",@"18000-25000€/año",@"25000-36000€/año",@"36000-50000€/año",@"50000-100000€/año",@"100000-250000€/año",@"+250000€/año",nil] 
			  retain];
	values = [[NSArray arrayWithObjects:
			   [NSNumber numberWithInt:0],
			   [NSNumber numberWithInt:12000],
			   [NSNumber numberWithInt:18000],
			   [NSNumber numberWithInt:25000],
			   [NSNumber numberWithInt:36000],
			   [NSNumber numberWithInt:50000],
			   [NSNumber numberWithInt:100000],
			   [NSNumber numberWithInt:250000],nil] 
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
	NSNumber *salary = [values objectAtIndex:[salaryPicker selectedRowInComponent:0]];
	[self saveIntoNSUD:salary];

	/*NationalitySelectorViewController *nsvc = [[NationalitySelectorViewController alloc] initWithNibName:@"NationalitySelectorViewController" bundle:nil];
	 [[self navigationController] pushViewController:nsvc animated:YES];
	 [nsvc release];*/
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	NSInteger count = 0;
	if (pickerView == salaryPicker) {
		count = 1;
	}
	return count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSInteger rowCount = 0;
	if (pickerView == salaryPicker) {
		rowCount = [values count];
	}	
	return rowCount;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSString *label = @"";
	if (pickerView == salaryPicker) {
		label = [labels objectAtIndex:row];
	}
	return label;
}


#pragma mark -
#pragma mark Private

- (void)saveIntoNSUD:(NSNumber*)salary {
	[[NSUserDefaultsManager sharedInstance] saveToUserDefaults:salary key:kUDMySalary];
	
	DLog(@"%@ %d %@ %@ %d %@",
		 [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDDesiredSex],
		 [[[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDDesiredAge] intValue],
		 [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDDesiredNationality],
		 [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDMySex],
		 [[[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDMyAge] intValue],
		 [[NSUserDefaultsManager sharedInstance] retrieveFromUserDefaults:kUDMySalary]);
}

#define kDBFilename @"db"

- (void)queryDB {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	// delete the old db.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:@"/tmp/tmp.db" error:nil];
    
	NSString *pdfBundlePath = [[NSBundle mainBundle] pathForResource:kDBFilename ofType:@"sqlite"];
	
    FMDatabase* db = [FMDatabase databaseWithPath:pdfBundlePath];
    if (![db open]) {
        DLog(@"Could not open db.");
        [pool release];
        return;
    }

    
    [db close];
}

@end
