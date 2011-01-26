    //
//  MainViewController.m
//  SurahMY
//
//  Created by Sumardi Shukor on 1/26/11.
//  Copyright 2011 Software Machine Development. All rights reserved.
//

#import "MainViewController.h"
#import "SurahMYAppDelegate.h"
#import "Surah.h"
#import "SurahViewController.h"

@implementation MainViewController

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Surah";
	
	tableData = [[NSMutableArray alloc] init];
	
	SurahMYAppDelegate *appDelegate = (SurahMYAppDelegate *)[[UIApplication sharedApplication] delegate];
	tableData = appDelegate.surahs;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Table view data source

// The number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

// The number of rows in a given specific section of the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell
	Surah *s = (Surah *)[tableData objectAtIndex:indexPath.row];
	cell.textLabel.text = [s.title capitalizedString];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

// Tells the delegate that the specified row is now selected.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SurahViewController *surahView = [[SurahViewController alloc] initWithNibName:@"SurahView" bundle:nil];
	surahView.title = [(Surah *)[tableData objectAtIndex:indexPath.row] title];
	surahView.selectedSurahIndex = [(Surah *)[tableData objectAtIndex:indexPath.row] index];
	
	// Create and push MemberDetails view controller.
	SurahMYAppDelegate *appDelegate = (SurahMYAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate.mainViewController pushViewController:surahView animated:YES];
	[surahView release];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    tableData = nil;
}


- (void)dealloc {
	[tableData release];
    [super dealloc];
}


@end
