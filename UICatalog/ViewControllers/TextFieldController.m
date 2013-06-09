/*
     File: TextFieldController.m 
 Abstract: The view controller for hosting the UITextField features of this sample. 
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

#import "TextFieldController.h"
#import "Constants.h"

#define kTextFieldWidth	260.0

static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";

// tableView cell id constants
static NSString *kTextFieldCellID = @"TextFieldCellID";
static NSString *kSourceCellID = @"SourceCellID";

const NSInteger kViewTag = 1;

@interface TextFieldController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textFieldNormal;
@property (nonatomic, strong) UITextField *textFieldRounded;
@property (nonatomic, strong) UITextField *textFieldSecure;
@property (nonatomic, strong) UITextField *textFieldLeftView;

@property (nonatomic, strong) NSArray *dataSourceArray;

@end


#pragma mark -

@implementation TextFieldController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.dataSourceArray = @[
                                @{  kSectionTitleKey:@"UITextField",
                                    kSourceKey:@"TextFieldController.m: textFieldNormal",
                                    kViewKey:self.textFieldNormal
                                },
                                @{  kSectionTitleKey:@"UITextField Rounded",
                                    kSourceKey:@"TextFieldController.m: textFieldRounded",
                                    kViewKey:self.textFieldRounded
                                },
                                @{  kSectionTitleKey:@"UITextField Secure",
                                    kSourceKey:@"TextFieldController.m: textFieldSecure",
                                    kViewKey:self.textFieldSecure
                                },
                                @{  kSectionTitleKey:@"UITextField (with LeftView)",
                                    kSourceKey:@"TextFieldController.m: textFieldLeftView",
                                    kViewKey:self.textFieldLeftView
                                }
							];
	
	self.title = NSLocalizedString(@"TextFieldTitle", @"");
	
	// we aren't editing any fields yet, it will be in edit when the user touches an edit field
	self.editing = NO;
    
    // register our cell IDs for later when we are asked for UITableViewCells
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTextFieldCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSourceCellID];
}


#pragma mark - UITableViewDataSource

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

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
    
	if ([indexPath row] == 0)
	{
		cell = [tableView dequeueReusableCellWithIdentifier:kTextFieldCellID forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        // remove the old edit field (if it contains one of our tagged edit fields)
        UIView *viewToCheck = nil;
        viewToCheck = [cell.contentView viewWithTag:kViewTag];
        if (viewToCheck)
            [viewToCheck removeFromSuperview];
		
		UITextField *textField = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kViewKey];
        
        // make sure this textfield's width matches the width of the cell
        CGRect newFrame = textField.frame;
        newFrame.size.width = CGRectGetWidth(cell.contentView.frame) - kLeftMargin*2;
        textField.frame = newFrame;
        
        // if the cell is ever resized, keep the textfield's width to match the cell's width
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
		[cell.contentView addSubview:textField];
	}
	else
	{
		cell = [tableView dequeueReusableCellWithIdentifier:kSourceCellID forIndexPath:indexPath];
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.highlightedTextColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
		
		cell.textLabel.text = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kSourceKey];
	}
	
    return cell;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}


#pragma mark - Text Fields

- (UITextField *)textFieldNormal
{
	if (_textFieldNormal == nil)
	{
		CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, kTextFieldHeight);
		_textFieldNormal = [[UITextField alloc] initWithFrame:frame];
		
		self.textFieldNormal.borderStyle = UITextBorderStyleBezel;
		self.textFieldNormal.textColor = [UIColor blackColor];
		self.textFieldNormal.font = [UIFont systemFontOfSize:17.0];
		self.textFieldNormal.placeholder = @"<enter text>";
		self.textFieldNormal.backgroundColor = [UIColor whiteColor];
		self.textFieldNormal.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		
		self.textFieldNormal.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
		self.textFieldNormal.returnKeyType = UIReturnKeyDone;
		
		self.textFieldNormal.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		
		self.textFieldNormal.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
		
		self.textFieldNormal.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
		
		// Add an accessibility label that describes what the text field is for.
		[self.textFieldNormal setAccessibilityLabel:NSLocalizedString(@"NormalTextField", @"")];
	}	
	return _textFieldNormal;
}

- (UITextField *)textFieldRounded
{
	if (_textFieldRounded == nil)
	{
		CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, kTextFieldHeight);
		_textFieldRounded = [[UITextField alloc] initWithFrame:frame];
		
		self.textFieldRounded.borderStyle = UITextBorderStyleRoundedRect;
		self.textFieldRounded.textColor = [UIColor blackColor];
		self.textFieldRounded.font = [UIFont systemFontOfSize:17.0];
		self.textFieldRounded.placeholder = @"<enter text>";
		self.textFieldRounded.backgroundColor = [UIColor whiteColor];
		self.textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		
		self.textFieldRounded.keyboardType = UIKeyboardTypeDefault;
		self.textFieldRounded.returnKeyType = UIReturnKeyDone;
		
		self.textFieldRounded.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		
		self.textFieldRounded.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
		
		self.textFieldRounded.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
		
		// Add an accessibility label that describes what the text field is for.
		[self.textFieldRounded setAccessibilityLabel:NSLocalizedString(@"RoundedTextField", @"")];
	}
	return _textFieldRounded;
}

- (UITextField *)textFieldSecure
{
	if (_textFieldSecure == nil)
	{
		CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, kTextFieldHeight);
		self.textFieldSecure = [[UITextField alloc] initWithFrame:frame];
		self.textFieldSecure.borderStyle = UITextBorderStyleBezel;
		self.textFieldSecure.textColor = [UIColor blackColor];
		self.textFieldSecure.font = [UIFont systemFontOfSize:17.0];
		self.textFieldSecure.placeholder = @"<enter password>";
		self.textFieldSecure.backgroundColor = [UIColor whiteColor];
		
		self.textFieldSecure.keyboardType = UIKeyboardTypeDefault;
		self.textFieldSecure.returnKeyType = UIReturnKeyDone;	
		self.textFieldSecure.secureTextEntry = YES;	// make the text entry secure (bullets)
		
		self.textFieldSecure.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		
		self.textFieldSecure.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
		
		self.textFieldSecure.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
		
		// Add an accessibility label that describes what the text field is for.
		[self.textFieldSecure setAccessibilityLabel:NSLocalizedString(@"SecureTextField", @"")];
	}
	return _textFieldSecure;
}

- (UITextField *)textFieldLeftView
{
	if (_textFieldLeftView == nil)
	{
		CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, kTextFieldHeight);
		_textFieldLeftView = [[UITextField alloc] initWithFrame:frame];
		self.textFieldLeftView.borderStyle = UITextBorderStyleBezel;
		self.textFieldLeftView.textColor = [UIColor blackColor];
		self.textFieldLeftView.font = [UIFont systemFontOfSize:17.0];
		self.textFieldLeftView.placeholder = @"<enter text>";
		self.textFieldLeftView.backgroundColor = [UIColor whiteColor];
		
		self.textFieldLeftView.keyboardType = UIKeyboardTypeDefault;
		self.textFieldLeftView.returnKeyType = UIReturnKeyDone;	
		
		self.textFieldLeftView.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		
		self.textFieldLeftView.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
		
		// Add an accessibility label that describes the text field.
		[self.textFieldLeftView setAccessibilityLabel:NSLocalizedString(@"CheckMarkIcon", @"")];
		
		UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment_check.png"]];
        self.textFieldLeftView.leftView = image;
		self.textFieldLeftView.leftViewMode = UITextFieldViewModeAlways;
		
		self.textFieldLeftView.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
	}
	return _textFieldLeftView;
}

@end

