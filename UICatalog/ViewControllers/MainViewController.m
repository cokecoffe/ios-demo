/*
     File: MainViewController.m 
 Abstract: The application's main view controller (front page).
  
  Version: 2.11 
  
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
  
 Copyright (C) 2013 Apple Inc. All Rights Reserved. 
  
 */

#import "MainViewController.h"

#import "ButtonsViewController.h"
#import "ControlsViewController.h"
#import "TextFieldController.h"
#import "SearchBarController.h"
#import "TextViewController.h"
#import "SegmentViewController.h"
#import "ToolbarViewController.h"
#import "PickerViewController.h"
#import "ImagesViewController.h"
#import "WebViewController.h"
#import "AlertsViewController.h"
#import "TransitionViewController.h"

#import "Constants.h"

static NSString *kTitleKey = @"title";
static NSString *kExplainKey = @"explanation";
static NSString *kViewControllerKey = @"viewController";

static NSString *kCellIdentifier = @"MyIdentifier";

@interface MyTableViewCell : UITableViewCell
@end

@implementation MyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
}

@end


#pragma mark -

@interface MainViewController ()
@property (nonatomic, strong) NSMutableArray *menuList;
@end


#pragma mark -

@implementation MainViewController

- (void)viewDidLoad
{	
	[super viewDidLoad];
	
    // construct the array of page descriptions we will use (each description is a dictionary)
	//
	self.menuList = [NSMutableArray array];
	
	// for showing various UIButtons:
	ButtonsViewController *buttonsViewController =
        [[ButtonsViewController alloc] initWithNibName:@"ButtonsViewController" bundle:nil];
	[self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"ButtonsTitle", @""),
                                kExplainKey:NSLocalizedString(@"ButtonsExplain", @""),
                                kViewControllerKey:buttonsViewController } ];
	
	// for showing various UIControls:
	ControlsViewController *controlsViewController =
        [[ControlsViewController alloc] initWithNibName:@"ControlsViewController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"ControlsTitle", @""),
                                kExplainKey:NSLocalizedString(@"ControlsExplain", @""),
                                kViewControllerKey:controlsViewController } ];
	
	// for showing various UITextFields:
	TextFieldController *textFieldViewController =
        [[TextFieldController alloc] initWithNibName:@"TextFieldController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"TextFieldTitle", @""),
                                kExplainKey:NSLocalizedString(@"TextFieldExplain", @""),
                                kViewControllerKey:textFieldViewController } ];
	
	// for UISearchBar:
	SearchBarController *searchBarController =
        [[SearchBarController alloc] initWithNibName:@"SearchBarController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"SearchBarTitle", @""),
                                kExplainKey:NSLocalizedString(@"SearchBarExplain", @""),
                                kViewControllerKey:searchBarController } ];
	
	// for showing UITextView:
	TextViewController *textViewController =
        [[TextViewController alloc] initWithNibName:@"TextViewController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"TextViewTitle", @""),
                                kExplainKey:NSLocalizedString(@"TextViewExplain", @""),
                                kViewControllerKey:textViewController } ];
	
	// for showing various UIPickers:
	PickerViewController *pickerViewController =
        [[PickerViewController alloc] initWithNibName:@"PickerViewController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"PickerTitle", @""),
                                kExplainKey:NSLocalizedString(@"PickerExplain", @""),
                                kViewControllerKey:pickerViewController } ];
	
	// for showing UIImageView:
	ImagesViewController *imagesViewController =
        [[ImagesViewController alloc] initWithNibName:@"ImagesViewController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"ImagesTitle", @""),
                                kExplainKey:NSLocalizedString(@"ImagesExplain", @""),
                                kViewControllerKey:imagesViewController } ];
	
	// for showing UIWebView:
	WebViewController *webViewController =
        [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"WebTitle", @""),
                                kExplainKey:NSLocalizedString(@"WebExplain", @""),
                                kViewControllerKey:webViewController } ];
    
	// for showing various UISegmentedControls:
	SegmentViewController *segmentViewController =
        [[SegmentViewController alloc] initWithNibName:@"SegmentViewController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"SegmentTitle", @""),
                                kExplainKey:NSLocalizedString(@"SegmentExplain", @""),
                                kViewControllerKey:segmentViewController } ];
	
	// for showing various UIBarButtonItem items inside a UIToolbar:
	ToolbarViewController *toolbarViewController =
        [[ToolbarViewController alloc] initWithNibName:@"ToolbarViewController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"ToolbarTitle", @""),
                                kExplainKey:NSLocalizedString(@"ToolbarExplain", @""),
                                kViewControllerKey:toolbarViewController } ];
	
	// for showing various UIActionSheets and UIAlertViews:
	AlertsViewController *alertsViewController =
        [[AlertsViewController alloc] initWithNibName:@"AlertsViewController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"AlertTitle", @""),
                                kExplainKey:NSLocalizedString(@"AlertExplain", @""),
                                kViewControllerKey:alertsViewController } ];
	
	// for showing how to a use flip animation transition between two UIViews:
	TransitionsViewController *transitionsViewController =
        [[TransitionsViewController alloc] initWithNibName:@"TransitionViewController" bundle:nil];
    [self.menuList addObject:@{ kTitleKey:NSLocalizedString(@"TransitionsTitle", @""),
                                kExplainKey:NSLocalizedString(@"TransitionsExplain", @""),
                                kViewControllerKey:transitionsViewController } ];

	// create a custom navigation bar button and set it to always say "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    // register our cell ID for later when we are asked for UITableViewCells
    [self.tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}


#pragma mark - UIViewController delegate

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    // this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    // some over view controller could have changed our nav bar tint color, so reset it here
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}


#pragma mark - UITableViewDelegate

// the table's selection has changed, switch to that item's UIViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIViewController *targetViewController = [[self.menuList objectAtIndex:indexPath.row] objectForKey:kViewControllerKey];
	[[self navigationController] pushViewController:targetViewController animated:YES];
}


#pragma mark - UITableViewDataSource

// tell our table how many rows it will have, in our case the size of our menuList
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.menuList count];
}

// tell our table what kind of cell to use and its title for the given row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [[self.menuList objectAtIndex:indexPath.row] objectForKey:kTitleKey];
    cell.detailTextLabel.text = [[self.menuList objectAtIndex:indexPath.row] objectForKey:kExplainKey];
    
	return cell;
}

@end