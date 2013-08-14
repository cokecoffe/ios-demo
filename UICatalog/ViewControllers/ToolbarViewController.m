/*
     File: ToolbarViewController.m 
 Abstract: The view controller for hosting the UIToolbar and UIBarButtonItem features of this sample. 
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

#import "ToolbarViewController.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface ToolbarViewController () <UINavigationBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UISegmentedControl *barStyleSegControl;
@property (nonatomic, strong) IBOutlet UISwitch *tintSwitch;

@property (nonatomic, strong) IBOutlet UISwitch *imageSwitch;
@property (nonatomic, strong) IBOutlet UILabel *imageSwitchLabel;

@property (nonatomic, strong) IBOutlet UISegmentedControl *buttonItemStyleSegControl;
@property (nonatomic, strong) IBOutlet UIPickerView *systemButtonPicker;

@property (nonatomic, strong) UIToolbar	*toolbar;
@property (nonatomic, strong) NSArray *pickerViewArray;

@property (nonatomic, assign) UIBarButtonSystemItem	currentSystemItem;

@property (assign) CGFloat savedContentHightSize;

@end


#pragma mark -

@implementation ToolbarViewController

// return the picker frame based on its size, positioned at the bottom of the page
- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(0.0,
								   CGRectGetHeight(screenRect) - 84.0 - size.height,
								   size.width,
								   size.height);
	return pickerRect;
}

- (void)action:(id)sender
{
	//NSLog(@"UIBarButtonItem clicked");
}

- (void)createToolbarItems
{	
	// match each of the toolbar item's style match the selection in the "UIBarButtonItemStyle" segmented control
	UIBarButtonItemStyle style = [self.buttonItemStyleSegControl selectedSegmentIndex];

	// create the system-defined "OK or Done" button
    UIBarButtonItem *systemItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:self.currentSystemItem
                                                                                target:self
                                                                                action:@selector(action:)];
	systemItem.style = style;
	
	// flex item used to separate the left groups items and right grouped items
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			   target:nil
																			   action:nil];
    
	// create a special tab bar item with a custom image and title
	UIBarButtonItem *infoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"segment_tools"]
																  style:style
																 target:self
																 action:@selector(action:)];
    
	// Set the accessibility label for an image bar item.
	[infoItem setAccessibilityLabel:NSLocalizedString(@"ToolsIcon", @"")];
	
    // create a custom button with a background image with black text for its title:
    UIBarButtonItem *customItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Item1"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(action:)];
    UIImage *baseImage = [UIImage imageNamed:@"whiteButton"];
    UIImage *backroundImage = [baseImage stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    [customItem1 setBackgroundImage:backroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    NSDictionary *textAttributes = @{ UITextAttributeTextColor:[UIColor blackColor] };
    [customItem1 setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    // create a bordered style button with custom title
	UIBarButtonItem *customItem2 = [[UIBarButtonItem alloc] initWithTitle:@"Item2"
																	style:style	// note you can use "UIBarButtonItemStyleDone" to make it blue
																   target:self
																   action:@selector(action:)];
    
	// apply the bar button items to the toolbar
    [self.toolbar setItems:@[ systemItem, flexItem, customItem1, customItem2, infoItem ] animated:NO];
}

- (void)adjustToolbarSize
{
    // size up the toolbar and set its frame
	[self.toolbar sizeToFit];
    
    // since the toolbar may have adjusted its height, it's origin will have to be adjusted too
	CGRect mainViewBounds = self.view.bounds;
	[self.toolbar setFrame:CGRectMake(CGRectGetMinX(mainViewBounds),
                                      CGRectGetMinY(mainViewBounds) + CGRectGetHeight(mainViewBounds) - CGRectGetHeight(self.toolbar.frame),
                                      CGRectGetWidth(mainViewBounds),
                                      CGRectGetHeight(self.toolbar.frame))];
}
- (void)viewDidLoad
{
	[super viewDidLoad];

	// this list appears in the UIPickerView to pick the system's UIBarButtonItem
	self.pickerViewArray = @[
                                @"Done",
                                @"Cancel",
                                @"Edit",  
                                @"Save",  
                                @"Add",
                                @"FlexibleSpace",
                                @"FixedSpace",
                                @"Compose",
                                @"Reply",
                                @"Action",
                                @"Organize",
                                @"Bookmarks",
                                @"Search",
                                @"Refresh",
                                @"Stop",
                                @"Camera",
                                @"Trash",
                                @"Play",
                                @"Pause",
                                @"Rewind",
                                @"FastForward",
                                @"Undo",
                                @"Redo",
                                @"PageCurl"
                            ];
	
	self.title = NSLocalizedString(@"ToolbarTitle", @"");
	
    // create the UIToolbar at the bottom of the view controller
	//
	_toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
	self.toolbar.barStyle = UIBarStyleDefault;
	
	// size up the toolbar and set its frame
    [self adjustToolbarSize];
    
	[self.toolbar setFrame:CGRectMake(CGRectGetMinX(self.view.bounds),
                                      CGRectGetMinY(self.view.bounds) + CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.toolbar.frame),
                                      CGRectGetWidth(self.view.bounds),
                                      CGRectGetHeight(self.toolbar.frame))];
    
    // make so the toolbar stays to the bottom and keep the width matching the device's screen width
    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
 
	[self.view addSubview:self.toolbar];

	[self createToolbarItems];
	
	// set the accessibility label for the tint and image switches so that its context can be determined
	[self.tintSwitch setAccessibilityLabel:NSLocalizedString(@"TintSwitch", @"")];
    [self.imageSwitch setAccessibilityLabel:NSLocalizedString(@"ImageSwitch", @"")];
    
    // remember our scroll view's content height (a fixed size) later when we set its content size in viewWillAppear
    self.savedContentHightSize = self.scrollView.frame.size.height -
                                    CGRectGetHeight(self.navigationController.navigationBar.frame) -
                                    self.toolbar.frame.size.height;
    
    self.currentSystemItem = UIBarButtonSystemItemDone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self adjustToolbarSize];
    
    // adjust the scroll view's height since the toolbar may have been resized
    CGFloat adjustedHeight = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.toolbar.frame);
    CGRect newFrame = self.scrollView.frame;
    newFrame.size.height = adjustedHeight;
    self.scrollView.frame = newFrame;
    
    // finally set the content size so that it scrolls in landscape but not in portrait
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), self.savedContentHightSize)];
}

- (IBAction)toggleStyle:(id)sender
{
	UIBarButtonItemStyle style = UIBarButtonItemStylePlain;
	
	switch ([sender selectedSegmentIndex])
	{
		case 0:	// UIBarButtonItemStylePlain
		{
			style = UIBarButtonItemStylePlain;
			break;
		}
		case 1: // UIBarButtonItemStyleBordered
		{	
			style = UIBarButtonItemStyleBordered;
			break;
		}
		case 2:	// UIBarButtonItemStyleDone
		{
			style = UIBarButtonItemStyleDone;
			break;
		}
	}

	// change all necessary bar button items to the given style
    NSArray *toolbarItems = self.toolbar.items;
	for (UIBarButtonItem *item in toolbarItems)
	{
		// skip setting the style of image-based UIBarButtonItems
        UIImage *image = [item backgroundImageForState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        if (image == nil)
        {
            item.style = style;
        }
	}
}

- (IBAction)toggleBarStyle:(id)sender
{
	switch ([sender selectedSegmentIndex])
	{
		case 0:
			self.toolbar.barStyle = UIBarStyleDefault;
			break;
		case 1:
			self.toolbar.barStyle = UIBarStyleBlackOpaque;
			break;
		case 2:
			self.toolbar.barStyle = UIBarStyleBlackTranslucent;
			break;
	}
}

- (IBAction)toggleTintColor:(id)sender
{
	UISwitch *switchCtl = (UISwitch *)sender;
	if (switchCtl.on)
	{
		self.toolbar.tintColor = [UIColor redColor];
		self.imageSwitch.enabled = self.barStyleSegControl.enabled = NO;
		self.imageSwitch.alpha = self.barStyleSegControl.alpha = 0.50;
	}
	else
	{
		if (self.imageSwitch.on)
            self.imageSwitch.enabled = self.barStyleSegControl.enabled = NO;
        else
            self.imageSwitch.enabled = self.barStyleSegControl.enabled = YES;
        
        self.toolbar.tintColor = nil; // no color
		self.imageSwitch.alpha = self.barStyleSegControl.alpha = 1.0;
	}
}

- (IBAction)toggleImage:(id)sender
{
	UISwitch *switchCtl = (UISwitch *)sender;
	if (switchCtl.on)
	{
		[self.toolbar setBackgroundImage:[UIImage imageNamed:@"toolbarBackground"]
                      forToolbarPosition:UIToolbarPositionBottom
                              barMetrics:UIBarMetricsDefault];
        self.tintSwitch.enabled = self.barStyleSegControl.enabled = NO;
		self.tintSwitch.alpha = self.barStyleSegControl.alpha = 0.50;
	}
	else
	{
		[self.toolbar setBackgroundImage:nil
                      forToolbarPosition:UIToolbarPositionBottom
                              barMetrics:UIBarMetricsDefault];
        self.tintSwitch.enabled = self.barStyleSegControl.enabled = YES;
		self.tintSwitch.alpha = self.barStyleSegControl.alpha = 1.0;
	}
}


#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	// change the left most bar item to what's in the picker
	self.currentSystemItem = [pickerView selectedRowInComponent:0];
	[self createToolbarItems];	// this will re-create all the items
}


#pragma mark - UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.pickerViewArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return 240.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.pickerViewArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

@end


