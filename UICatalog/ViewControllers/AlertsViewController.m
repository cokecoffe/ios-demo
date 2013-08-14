/*
     File: AlertsViewController.m 
 Abstract: The view controller for hosting various kinds of alerts and action sheets 
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

#import "AlertsViewController.h"

static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kLabelKey = @"labelKey";
static NSString *kSourceKey = @"sourceKey";

// tableView cell id constants
static NSString *kAlertCellID = @"AlertCellID";
static NSString *kSourceCellID = @"SourceCellID";

enum AlertTableSections
{
	kUIAction_Simple_Section = 0,
	kUIAction_OKCancel_Section,
	kUIAction_Custom_Section,
	kUIAlert_Simple_Section,
	kUIAlert_OKCancel_Section,
	kUIAlert_Custom_Section,
    kUIAlert_SecureText_Section
};

@interface AlertsViewController () <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSArray *dataSourceArray;

@end


#pragma mark -

@implementation AlertsViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"AlertTitle", @"");

	self.dataSourceArray = @[
                            @{  kSectionTitleKey:@"UIActionSheet",
                                kLabelKey:@"Show Simple",
                                kSourceKey:@"AlertsViewController.m - dialogSimpleAction" },
                            
                            @{  kSectionTitleKey:@"UIActionSheet",
                                kLabelKey:@"Show OK-Cancel",
                                kSourceKey:@"AlertsViewController.m - dialogOKCancelAction" },
                            
                            @{  kSectionTitleKey:@"UIActionSheet",
                                kLabelKey:@"Show Customized",
                                kSourceKey:@"AlertsViewController.m - dialogOtherAction" },
                            
                            @{  kSectionTitleKey:@"UIAlertView",
                                kLabelKey:@"Show Simple",
                                kSourceKey:@"AlertsViewController.m - alertSimpleAction" },
							
                            @{  kSectionTitleKey:@"UIAlertView",
                                kLabelKey:@"Show OK-Cancel",
                                kSourceKey:@"AlertsViewController.m - alertOKCancelAction" },
                            
                            @{  kSectionTitleKey:@"UIAlertView",
                                kLabelKey:@"Show Custom",
                                kSourceKey:@"AlertsViewController.m - alertOtherAction" },
                            
                            @{  kSectionTitleKey:@"UIAlertView",
                                kLabelKey:@"Secure Text Input",
                                kSourceKey:@"AlertsViewController.m - alertSecureTextAction" }
                            ];
    
    // register our cell IDs for later when we are asked for UITableViewCells
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kAlertCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSourceCellID];
}


#pragma mark - UIActionSheet

- (void)dialogSimpleAction
{
	// open a dialog with just an OK button
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"UIActionSheetTitle", nil)
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:NSLocalizedString(@"OKButtonTitle", nil)
                                                    otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view];	// show from our table view (pops up in the middle of the table)
}

- (void)dialogOKCancelAction
{
	// open a dialog with an OK and cancel button
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"UIActionSheetTitle", nil)
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"CancelButtonTitle", nil)
                                               destructiveButtonTitle:NSLocalizedString(@"OKButtonTitle", nil)
                                                    otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
}

- (void)dialogOtherAction
{
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"UIActionSheetTitle", nil)
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"ButtonTitle1", nil),
                                                                      NSLocalizedString(@"ButtonTitle2", nil), nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
}


#pragma mark - UIAlertView

- (void)alertSimpleAction
{
	// open an alert with just an OK button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UIAlertViewTitle", nil)
                                                    message:NSLocalizedString(@"UIAlertViewMessageGeneric", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"OKButtonTitle", nil)
                                          otherButtonTitles:nil];
	[alert show];	
}

- (void)alertOKCancelAction
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UIAlertViewTitle", nil)
                                                    message:NSLocalizedString(@"UIAlertViewMessageGeneric", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"CancelButtonTitle", nil)
                                          otherButtonTitles:NSLocalizedString(@"OKButtonTitle", nil), nil];
	[alert show];
}

- (void)alertOtherAction
{
	// open an alert with two custom buttons
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UIAlertViewTitle", nil)
                                                    message:NSLocalizedString(@"UIAlertViewMessageGeneric", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"CancelButtonTitle", nil)
                                          otherButtonTitles:NSLocalizedString(@"ButtonTitle1", nil),
                                                            NSLocalizedString(@"ButtonTitle2", nil), nil];
	[alert show];
}

- (void)alertSecureTextAction
{
	// open an alert with two custom buttons
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UIAlertViewTitle", nil)
                                                    message:NSLocalizedString(@"UIAlertViewMessage", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"CancelButtonTitle", nil)
                                          otherButtonTitles:NSLocalizedString(@"OKButtonTitle", nil), nil];
	alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alert show];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		//NSLog(@"ok");
	}
	else
	{
		//NSLog(@"cancel");
	}
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// use "buttonIndex" to decide your action
	//
}


#pragma mark - UITableView delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.dataSourceArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[self.dataSourceArray objectAtIndex: section] valueForKey:kSectionTitleKey];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

// to determine specific row height for each cell, override this.
// In this example, each row is determined by its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return ([indexPath row] == 0) ? 50.0 : 22.0;
}

// the table's selection has changed, show the alert or action sheet
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// deselect the current row (don't keep the table selection persistent)
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
	
	if (indexPath.row == 0)
	{
		switch (indexPath.section)
		{
			case kUIAction_Simple_Section:
				[self dialogSimpleAction];
                break;
				
			case kUIAction_OKCancel_Section:
				[self dialogOKCancelAction];
				break;
				
			case kUIAction_Custom_Section:
				[self dialogOtherAction];
				break;
				
			case kUIAlert_Simple_Section:
				[self alertSimpleAction];
				break;
				
			case kUIAlert_OKCancel_Section:
				[self alertOKCancelAction];	
				break;
				
			case kUIAlert_Custom_Section:
				[self alertOtherAction];	
				break;
                
            case kUIAlert_SecureText_Section:
				[self alertSecureTextAction];	
				break;
		}
	}
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	
	if ([indexPath row] == 0)
	{
		cell = [tableView dequeueReusableCellWithIdentifier:kAlertCellID forIndexPath:indexPath];
		cell.textLabel.text = [[self.dataSourceArray objectAtIndex:indexPath.section] valueForKey:kLabelKey];
	}	
	else
	{
		cell = [tableView dequeueReusableCellWithIdentifier:kSourceCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.opaque = NO;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
		
		cell.textLabel.text = [[self.dataSourceArray objectAtIndex:indexPath.section] valueForKey:kSourceKey];
	}
	
	return cell;
}

@end

