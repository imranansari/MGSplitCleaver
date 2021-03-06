//
//  RootViewController_iPhone.m
//  MGSplitView
//
//  Created by Randy McMillan on 11/17/12.
//
//

#import "RootViewController_iPhone.h"
#import "DetailViewController_iPhone.h"

@implementation RootViewController_iPhone

@synthesize detailViewController_iPhone;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.clearsSelectionOnViewWillAppear	= NO;
	self.contentSizeForViewInPopover		= CGSizeMake(320.0, 600.0);
}

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)selectFirstRow
{
	if (([self.tableView numberOfSections] > 0) && ([self.tableView numberOfRowsInSection:0] > 0)) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		[self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
		[self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
	}
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"CellIdentifier";

	// Dequeue or create a cell of the appropriate type.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

	// Configure the cell.
	cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];

	DetailViewController_iPhone *detailViewController_iPhone = [[DetailViewController_iPhone alloc]init];

	if (IS_IPAD()) {} else {
		[self.navigationController pushViewController:detailViewController_iPhone animated:YES];
	}

	// When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
	detailViewController_iPhone.detailDescriptionLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    
    NSString *jsString = [NSString stringWithFormat:@"navigator.notification.alert('indexPath.row %d selected!',alertDismissed,'Event triggered from native','OK');",indexPath.row];
    [detailViewController_iPhone webViewShowAlert:jsString];
    
    
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[detailViewController_iPhone release];
	[super dealloc];
}

@end
