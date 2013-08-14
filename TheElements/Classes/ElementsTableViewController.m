/*
     File: ElementsTableViewController.m
 Abstract: Coordinates the tableviews and element data sources. It also responds
 to changes of selection in the table view and provides the cells.
  Version: 1.11
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "ElementsTableViewController.h"

#import "AtomicElement.h"
#import "AtomicElementTableViewCell.h"
#import "AtomicElementViewController.h"
#import "TheElementsAppDelegate.h"
#import "ElementsDataSourceProtocol.h"


@implementation ElementsTableViewController

@synthesize theTableView;
@synthesize dataSource;
 

// this is the custom initialization method for the ElementsTableViewController
// it expects an object that conforms to both the UITableViewDataSource protocol
// which provides data to the tableview, and the ElementDataSource protocol which
// provides information about the elements data that is displayed,
- (id)initWithDataSource:(id<ElementsDataSource,UITableViewDataSource>)theDataSource {
	if ([self init]) {
		theTableView = nil;
		
		// retain the data source
		self.dataSource = theDataSource;
		// set the title, and tab bar images from the dataSource
		// object. These are part of the ElementsDataSource Protocol
		self.title = [dataSource name];
		self.tabBarItem.image = [dataSource tabBarImage];

		// set the long name shown in the navigation bar
		self.navigationItem.title=[dataSource navigationBarName];

		// create a custom navigation bar button and set it to always say "back"
		UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
		temporaryBarButtonItem.title=@"Back";
		self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
		[temporaryBarButtonItem release];
		
	}
	return self;
}


- (void)dealloc {
	theTableView.delegate = nil;
	theTableView.dataSource = nil;
	[theTableView release];
	[dataSource release];
	[super dealloc];
}


- (void)loadView {
	
	// create a new table using the full application frame
	// we'll ask the datasource which type of table to use (plain or grouped)
	UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] 
														  style:[dataSource tableViewStyle]];
	
	// set the autoresizing mask so that the table will always fill the view
	tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
	
	// set the cell separator to a single straight line.
	tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	
	// set the tableview delegate to this object and the datasource to the datasource which has already been set
	tableView.delegate = self;
	tableView.dataSource = dataSource;
	
	tableView.sectionIndexMinimumDisplayRowCount=10;

	// set the tableview as the controller view
    self.theTableView = tableView;
	self.view = tableView;
	[tableView release];

}

-(void)viewWillAppear:(BOOL)animated
{
	// force the tableview to load

	[theTableView reloadData];
}


//
//
// UITableViewDelegate methods
//
//

// the user selected a row in the table.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {
	// deselect the new row using animation
    [tableView deselectRowAtIndexPath:newIndexPath animated:YES];
	
	// get the element that is represented by the selected row.
	AtomicElement *element = [dataSource atomicElementForIndexPath:newIndexPath];
	
	// create an AtomicElementViewController. This controller will display the full size tile for the element
	AtomicElementViewController *elementController = [[AtomicElementViewController alloc] init];

	// set the element for the controller
	elementController.element = element;
	
	// push the element view controller onto the navigation stack to display it
	[[self navigationController] pushViewController:elementController animated:YES];
	[elementController release];
}



@end
