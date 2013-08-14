/*
     File: ButtonsViewController.m 
 Abstract: The table view controller for hosting the UIButton features of this sample. 
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

#import "ButtonsViewController.h"
#import "Constants.h"

#define kStdButtonWidth		106.0
#define kStdButtonHeight	40.0

#define kViewTag			1		// for tagging our embedded controls for removal at cell recycle time

static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kLabelKey = @"labelKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";

// tableView cell id constants
static NSString *kDisplayCellID = @"DisplayCellID";
static NSString *kSourceCellID = @"SourceCellID";


#pragma mark -

@interface ButtonsViewController ()

@property (nonatomic, strong) UIButton *grayButton;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIButton *attrTextButton;
@property (nonatomic, strong) UIButton *roundedButtonType;

@property (nonatomic, strong) UIButton *detailDisclosureButtonType;

@property (nonatomic, strong) UIButton *infoLightButtonType;
@property (nonatomic, strong) UIButton *infoDarkButtonType;

@property (nonatomic, strong) UIButton *contactAddButtonType;

@property (nonatomic, strong) NSArray *dataSourceArray;

@end


#pragma mark -

@implementation ButtonsViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"ButtonsTitle", @"");
	
	self.dataSourceArray = @[
                                @{  kSectionTitleKey:@"UIButton",
                                    kLabelKey:@"Background Image",
                                    kSourceKey:@"ButtonsViewController.m:\r(UIButton *)grayButton",
                                    kViewKey:self.grayButton },
                            
                                @{  kSectionTitleKey:@"UIButton",
                                    kLabelKey:@"Button with Image",
                                    kSourceKey:@"ButtonsViewController.m:\r(UIButton *)imageButton",
                                    kViewKey:self.imageButton },

                                @{  kSectionTitleKey:@"UIButtonTypeRoundedRect",
                                    kLabelKey:@"Rounded Button",
                                    kSourceKey:@"ButtonsViewController.m:\r(UIButton *)roundedButtonType",
                                    kViewKey:self.roundedButtonType },
                                
                                @{  kSectionTitleKey:@"UIButtonTypeRoundedRect",
                                    kLabelKey:@"Attributed Text",
                                    kSourceKey:@"ButtonsViewController.m:\r(UIButton *)attrTextButton",
                                    kViewKey:self.attrTextButton },
                        
                                @{  kSectionTitleKey:@"UIButtonTypeDetailDisclosure",
                                    kLabelKey:@"Detail Disclosure",
                                    kSourceKey:@"ButtonsViewController.m:\r(UIButton *)detailDisclosureButton",
                                    kViewKey:self.detailDisclosureButtonType },
                        
                                @{  kSectionTitleKey:@"UIButtonTypeInfoLight",
                                    kLabelKey:@"Info Light",
                                    kSourceKey:@"ButtonsViewController.m:\r(UIButton *)infoLightButtonType",
                                    kViewKey:self.infoLightButtonType},
                        
                                @{  kSectionTitleKey:@"UIButtonTypeInfoDark",
                                    kLabelKey:@"Info Dark",
                                    kSourceKey:@"ButtonsViewController.m:\r(UIButton *)infoDarkButtonType",
                                    kViewKey:self.infoDarkButtonType},
                        
                                @{  kSectionTitleKey:@"UIButtonTypeContactAdd",
                                    kLabelKey:@"Contact Add",
                                    kSourceKey:@"ButtonsViewController.m:\r(UIButton *)contactAddButtonType",
                                    kViewKey:self.contactAddButtonType}
                            ];
    
    // register our cell IDs for later when we are asked for UITableViewCells
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDisplayCellID];
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
	return ([indexPath row] == 0) ? 50.0 : 38.0;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	
	if ([indexPath row] == 0)
	{
		cell = [tableView dequeueReusableCellWithIdentifier:kDisplayCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        // remove old embedded control
        UIView *viewToRemove = nil;
        viewToRemove = [cell.contentView viewWithTag:kViewTag];
        if (viewToRemove)
            [viewToRemove removeFromSuperview];
		
		cell.textLabel.text = [[self.dataSourceArray objectAtIndex:indexPath.section] valueForKey:kLabelKey];
		
		UIButton *button = [[self.dataSourceArray objectAtIndex:indexPath.section] valueForKey:kViewKey];
        
        // make sure this button is right-justified to the right side of the cell
        CGRect newFrame = button.frame;
        newFrame.origin.x = CGRectGetWidth(cell.contentView.frame) - CGRectGetWidth(newFrame) - 10.0;
        button.frame = newFrame;
        
        // if the cell is ever resized, keep the button over to the right
        button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        
        [cell.contentView addSubview:button];
	}
	else
	{
		cell = [tableView dequeueReusableCellWithIdentifier:kSourceCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.textLabel.opaque = NO;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.highlightedTextColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
		cell.textLabel.text = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kSourceKey];
	}

	return cell;
}


#pragma mark -

+ (UIButton *)newButtonWithTitle:(NSString *)title
					   target:(id)target
					 selector:(SEL)selector
						frame:(CGRect)frame
						image:(UIImage *)image
				 imagePressed:(UIImage *)imagePressed
				darkTextColor:(BOOL)darkTextColor
{	
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	// or you can do this:
	//		UIButton *button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	[button setTitle:title forState:UIControlStateNormal];	
	if (darkTextColor)
	{
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	}
	else
	{
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	
	UIImage *newImage = [image stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newImage forState:UIControlStateNormal];
	
	UIImage *newPressedImage = [imagePressed stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
	
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
    // in case the parent view draws with a custom color or gradient, use a transparent color
	button.backgroundColor = [UIColor clearColor];
    
	return button;
}

- (void)action:(id)sender
{
	//NSLog(@"UIButton was clicked");
}


#pragma mark - Lazy creation of buttons

- (UIButton *)grayButton
{	
	if (_grayButton == nil)
	{
		// create the UIButtons with various background images
		// white button:
		UIImage *buttonBackground = [UIImage imageNamed:@"whiteButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"blueButton.png"];
		
		CGRect frame = CGRectMake(0.0, 5.0, kStdButtonWidth, kStdButtonHeight);
		
		_grayButton = [ButtonsViewController newButtonWithTitle:@"Gray"
													 target:self
												   selector:@selector(action:)
													  frame:frame
													  image:buttonBackground
											   imagePressed:buttonBackgroundPressed
											  darkTextColor:YES];
		
		_grayButton.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return _grayButton;
}

- (UIButton *)imageButton
{	
	if (_imageButton == nil)
	{
		// create a UIButton with just an image instead of a title
		
		UIImage *buttonBackground = [UIImage imageNamed:@"whiteButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"blueButton.png"];
		
		CGRect frame = CGRectMake(0.0, 5.0, kStdButtonWidth, kStdButtonHeight);
		
		_imageButton = [ButtonsViewController newButtonWithTitle:@""
													  target:self
													selector:@selector(action:)
													   frame:frame
													   image:buttonBackground
												imagePressed:buttonBackgroundPressed
											   darkTextColor:YES];
		
		[_imageButton setImage:[UIImage imageNamed:@"UIButton_custom.png"] forState:UIControlStateNormal];
		
		// Add an accessibility label to the image.
		[_imageButton setAccessibilityLabel:NSLocalizedString(@"ArrowButton", @"")];
		
		_imageButton.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return _imageButton;
}

- (UIButton *)attrTextButton
{
    if (_attrTextButton == nil)
	{
		// create a UIButton with attributed text for its title
		_attrTextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		_attrTextButton.frame = CGRectMake(0.0, 5.0, kStdButtonWidth, kStdButtonHeight);
		[_attrTextButton setTitle:@"Rounded" forState:UIControlStateNormal];
		[_attrTextButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
		// Add an accessibility label to the image.
		[_attrTextButton setAccessibilityLabel:NSLocalizedString(@"AttrTextButton", @"")];

        // apply red text for normal state
        NSMutableAttributedString *normalAttrString = [[NSMutableAttributedString alloc] initWithString:@"Rounded"];
        [normalAttrString addAttribute:NSForegroundColorAttributeName
                           value:[UIColor redColor]
                           range:NSMakeRange(0, [normalAttrString length])];
        [_attrTextButton setAttributedTitle:normalAttrString forState:UIControlStateNormal];
        
        // apply green text for pressed state
        NSMutableAttributedString *highlightedAttrString = [[NSMutableAttributedString alloc] initWithString:@"Rounded"];
        [highlightedAttrString addAttribute:NSForegroundColorAttributeName
                           value:[UIColor greenColor]
                           range:NSMakeRange(0, [highlightedAttrString length])];
        [_attrTextButton setAttributedTitle:highlightedAttrString forState:UIControlStateHighlighted];
        
		_attrTextButton.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return _attrTextButton;
}

- (UIButton *)roundedButtonType
{
	if (_roundedButtonType == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		_roundedButtonType = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		_roundedButtonType.frame = CGRectMake(0.0, 5.0, kStdButtonWidth, kStdButtonHeight);
		[_roundedButtonType setTitle:@"Rounded" forState:UIControlStateNormal];
		[_roundedButtonType addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		_roundedButtonType.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return _roundedButtonType;
}

- (UIButton *)detailDisclosureButtonType
{
	if (_detailDisclosureButtonType == nil)
	{
		// create a UIButton (UIButtonTypeDetailDisclosure)
		_detailDisclosureButtonType = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		_detailDisclosureButtonType.frame = CGRectMake(0.0, 8.0, 25.0, 25.0);
		[_detailDisclosureButtonType setTitle:@"Detail Disclosure" forState:UIControlStateNormal];
		_detailDisclosureButtonType.backgroundColor = [UIColor clearColor];
		[_detailDisclosureButtonType addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		// Add a custom accessibility label to the button because it has no associated text.
		[_detailDisclosureButtonType setAccessibilityLabel:NSLocalizedString(@"MoreInfoButton", @"")];

		_detailDisclosureButtonType.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return _detailDisclosureButtonType;
}

- (UIButton *)infoDarkButtonType
{
	if (_infoDarkButtonType == nil)
	{
		// create a UIButton (UIButtonTypeInfoLight)
		_infoDarkButtonType = [UIButton buttonWithType:UIButtonTypeInfoDark];
		_infoDarkButtonType.frame = CGRectMake(0.0, 8.0, 25.0, 25.0);
		[_infoDarkButtonType setTitle:@"Detail Disclosure" forState:UIControlStateNormal];
		_infoDarkButtonType.backgroundColor = [UIColor clearColor];
		[_infoDarkButtonType addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		// Add a custom accessibility label to the button because it has no associated text.
		[_infoDarkButtonType setAccessibilityLabel:NSLocalizedString(@"MoreInfoButton", @"")];

		_infoDarkButtonType.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return _infoDarkButtonType;
}

- (UIButton *)infoLightButtonType
{
	if (_infoLightButtonType == nil)
	{
		// create a UIButton (UIButtonTypeInfoLight)
		_infoLightButtonType = [UIButton buttonWithType:UIButtonTypeInfoLight];
		_infoLightButtonType.frame = CGRectMake(0.0, 8.0, 25.0, 25.0);
		[_infoLightButtonType setTitle:@"Detail Disclosure" forState:UIControlStateNormal];
		_infoLightButtonType.backgroundColor = [UIColor clearColor];
		[_infoLightButtonType addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		_infoLightButtonType.backgroundColor = [UIColor grayColor];
		
		// Add a custom accessibility label to the button because it has no associated text.
		[_infoLightButtonType setAccessibilityLabel:NSLocalizedString(@"MoreInfoButton", @"")];

		_infoLightButtonType.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	
	return _infoLightButtonType;
}

- (UIButton *)contactAddButtonType
{
	if (_contactAddButtonType == nil)
	{
		// create a UIButton (UIButtonTypeContactAdd)
		_contactAddButtonType = [UIButton buttonWithType:UIButtonTypeContactAdd];
		_contactAddButtonType.frame = CGRectMake(0.0, 8.0, 25.0, 25.0);
		[_contactAddButtonType setTitle:@"Detail Disclosure" forState:UIControlStateNormal];
		_contactAddButtonType.backgroundColor = [UIColor clearColor];
		[_contactAddButtonType addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		// Add a custom accessibility label to the button because it has no associated text.
		[_contactAddButtonType setAccessibilityLabel:NSLocalizedString(@"AddContactButton", @"")];
		
		_contactAddButtonType.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return _contactAddButtonType;
}

@end

