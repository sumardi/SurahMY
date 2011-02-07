//
//  SurahViewController.m
//  SurahMY
//
//  Created by Sumardi Shukor on 1/27/11.
//  Copyright 2011 Software Machine Development. All rights reserved.
//

#import "SurahViewController.h"
#import "Ayat.h"

@implementation SurahViewController

@synthesize tableData;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
																	style:UIBarButtonSystemItemDone target:nil action:nil];
	UIImage *btnImage = [UIImage imageNamed:@"mic_ico.png"];
	//[rightButton setImage:btnImage forState:UIControlStateNormal];
	rightButton.image = btnImage;
	self.navigationItem.rightBarButtonItem = rightButton;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [tableData count];
}

- (UIImage *)scaleImage:(UIImage *) image maxWidth:(float) maxWidth maxHeight:(float) maxHeight
{
	CGImageRef imgRef = image.CGImage;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	if (width <= maxWidth && height <= maxHeight)
	{
		return image;
	}
	
	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(10, 10, width, height);
	
	if (width > maxWidth || height > maxHeight)
	{
		CGFloat ratio = width/height;
		
		if (ratio > 1)
		{
			bounds.size.width = maxWidth;
			bounds.size.height = bounds.size.width / ratio;
		}
		else
		{
			bounds.size.height = maxHeight;
			bounds.size.width = bounds.size.height * ratio;
		}
	}
	
	CGFloat scaleRatio = bounds.size.width / width;
	UIGraphicsBeginImageContext(bounds.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextScaleCTM(context, scaleRatio, -scaleRatio);
	CGContextTranslateCTM(context, 0, -height);
	CGContextConcatCTM(context, transform);
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageCopy;
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Ayat *a = (Ayat *)[tableData objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	//UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",a.folder,a.image]];
	//NSLog(@"%@", img.size.width);
	UIImage *img = [self scaleImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",a.folder,a.image]] maxWidth:310 maxHeight:500];
	
	UIImageView *image = [[UIImageView alloc] initWithImage:img];
	image.contentMode = UIViewContentModeScaleAspectFill;
	
	
	CGRect CellFrame = CGRectMake(0, 0, 320, img.size.height);
	
    //if (cell == nil) {
//		UIImageView *imageView = nil;
//		UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",a.folder,a.image]];
		
		cell = [[[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0];
	
//		imageView = [[UIImageView alloc] initWithImage:img];
//		imageView.contentMode = UIViewContentModeScaleAspectFit;
		//cell.backgroundColor = [UIColor redColor];
		//cell.backgroundView = imageView;
		//imageView.frame = CGRectMake(10, 10, 390, 40);
		//cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	//imageView.frame = CGRectMake(10, 8, 290, 40);
		[cell.contentView addSubview:image];
	//[cell.contentView addSubview:txt];
	//txt.text = a.title;
//		[imageView release];
//		[img release];
	//}
//    cell.textLabel.textAlignment = UITextAlignmentRight;
    // Set up the cell
	cell.textLabel.text = [a.title capitalizedString];    
	//tableView.opaque = NO;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	Ayat *a = (Ayat *)[tableData objectAtIndex:indexPath.row];
	UIImage *img = [self scaleImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",a.folder,a.image]] maxWidth:310 maxHeight:500];
	
	NSString *cellText = a.title;
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:13.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT); 
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	
    return labelSize.height + (img.size.height * 2);
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    tableData = nil;
}


- (void)dealloc {
	[tableData release];
    [super dealloc];
}


@end

