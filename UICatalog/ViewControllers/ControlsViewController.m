/*
     File: ControlsViewController.m 
 Abstract: The view controller for hosting the UIControls features of this sample. 
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

#import "ControlsViewController.h"
#import "Constants.h"

#define kSliderHeight			7.0
#define kProgressIndicatorSize	40.0

#define kUIProgressBarWidth		160.0
#define kUIProgressBarHeight	24.0

#define kViewTag				1		// for tagging our embedded controls for removal at cell recycle time

static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kLabelKey = @"labelKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";

// tableView cell id constants
static NSString *kDisplayCellID = @"DisplayCellID";
static NSString *kSourceCellID = @"SourceCellID";


#pragma mark -

@interface ControlsViewController ()

@property (nonatomic, strong) UISwitch *switchCtl;
@property (nonatomic, strong) UISlider *sliderCtl;
@property (nonatomic, strong) UISlider *customSlider;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIActivityIndicatorView *progressInd;
@property (nonatomic, strong) UIColor *progressIndSavedColor;

@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong) UIStepper *stepper;

@property (nonatomic, strong) NSArray *dataSourceArray;

@end


#pragma mark -

@implementation ControlsViewController

- (void)viewDidLoad
{	
    [super viewDidLoad];
    
	self.title = NSLocalizedString(@"ControlsTitle", @"");

	self.dataSourceArray = @[
                            @{  kSectionTitleKey:@"UISwitch",
                                kLabelKey:@"Standard Switch",
                                kSourceKey:@"ControlsViewController.m:\r-(UISwitch *)switchCtl",
                                kViewKey:self.switchCtl },
                            
                            @{  kSectionTitleKey:@"UISlider",
                                kLabelKey:@"Standard Slider",
                                kSourceKey:@"ControlsViewController.m:\r-(UISlider *)sliderCtl",
                                kViewKey:self.sliderCtl },
							
                            @{  kSectionTitleKey:@"UISlider",
                                kLabelKey:@"Customized Slider",
                                kSourceKey:@"ControlsViewController.m:\r-(UISlider *)customSlider",
                                kViewKey:self.customSlider },
							
							@{  kSectionTitleKey:@"UIPageControl",
                                kLabelKey:@"Ten Pages",
                                kSourceKey:@"ControlsViewController.m:\r-(UIPageControl *)pageControl",
                                kViewKey:self.pageControl },
							
							@{  kSectionTitleKey:@"UIActivityIndicatorView",
                                kLabelKey:@"Style Gray",
                                kSourceKey:@"ControlsViewController.m:\r-(UIActivityIndicatorView *)progressInd",
                                kViewKey:self.progressInd },
							
                            @{  kSectionTitleKey:@"UIProgressView",
                                kLabelKey:@"Style Default",
                                kSourceKey:@"ControlsViewController.m:\r-(UIProgressView *)progressBar",
                                kViewKey:self.progressBar },
                            
                            @{  kSectionTitleKey:@"UIStepper",
                                kLabelKey:@"Stepper 1 to 10",
                                kSourceKey:@"ControlsViewController.m:\r-(UIStepper *)stepper",
                                kViewKey:self.stepper }
							];
    
    // add tint bar button
    UIBarButtonItem *tintButton = [[UIBarButtonItem alloc] initWithTitle:@"Tinted"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(tintAction:)];
    self.navigationItem.rightBarButtonItem = tintButton;
    
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

        UIView *viewToRemove = nil;
        viewToRemove = [cell.contentView viewWithTag:kViewTag];
        if (viewToRemove)
            [viewToRemove removeFromSuperview];
		
		cell.textLabel.text = [[self.dataSourceArray objectAtIndex:indexPath.section] valueForKey:kLabelKey];
		
		UIControl *control = [[self.dataSourceArray objectAtIndex:indexPath.section] valueForKey:kViewKey];
        
        // make sure this control is right-justified to the right side of the cell
        CGRect newFrame = control.frame;
        newFrame.origin.x = CGRectGetWidth(cell.contentView.frame) - CGRectGetWidth(newFrame) - 10.0;
        control.frame = newFrame;
        
        // if the cell is ever resized, keep the control over to the right
        control.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        
		[cell.contentView addSubview:control];
        
        if (control == (UIControl *)self.progressInd)
        {
            [self.progressInd startAnimating];  // UIActivityIndicatorView needs to re-animate
        }
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
		
		cell.textLabel.text = [[self.dataSourceArray objectAtIndex:indexPath.section] valueForKey:kSourceKey];
	}

	return cell;
}

- (void)switchAction:(id)sender
{
	// NSLog(@"switchAction: value = %d", [sender isOn]);
}

- (void)pageAction:(id)sender
{
	// NSLog(@"pageAction: current page = %d", [sender currentPage]);
}

- (void)sliderAction:(id)sender
{
    // UISlider *slider = (UISlider *)sender;
    // NSLog(@"sliderAction: value = %f", [slider value]);
}

- (void)stepperAction:(id)sender
{
    // UIStepper *actualStepper = (UIStepper *)sender;
    // NSLog(@"stepperAction: value = %f", [actualStepper value]);
}


#pragma mark - Lazy creation of controls

- (UISwitch *)switchCtl
{
    if (_switchCtl == nil)
    {
        CGRect frame = CGRectMake(0.0, 12.0, 94.0, 27.0);
        _switchCtl = [[UISwitch alloc] initWithFrame:frame];
        [_switchCtl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        // in case the parent view draws with a custom color or gradient, use a transparent color
        _switchCtl.backgroundColor = [UIColor clearColor];
		
		[_switchCtl setAccessibilityLabel:NSLocalizedString(@"StandardSwitch", @"")];
		
		_switchCtl.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
    }
    return _switchCtl;
}

- (UISlider *)sliderCtl
{
    if (_sliderCtl == nil)
    {
        CGRect frame = CGRectMake(0.0, 12.0, 120.0, kSliderHeight);
        _sliderCtl = [[UISlider alloc] initWithFrame:frame];
        [_sliderCtl addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        
        // in case the parent view draws with a custom color or gradient, use a transparent color
        _sliderCtl.backgroundColor = [UIColor clearColor];
        
        _sliderCtl.minimumValue = 0.0;
        _sliderCtl.maximumValue = 100.0;
        _sliderCtl.continuous = YES;
        _sliderCtl.value = 50.0;

		// Add an accessibility label that describes the slider.
		[_sliderCtl setAccessibilityLabel:NSLocalizedString(@"StandardSlider", @"")];
		
		_sliderCtl.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
    }
    return _sliderCtl;
}

- (UISlider *)customSlider
{
    if (_customSlider == nil)
    {
        CGRect frame = CGRectMake(0.0, 12.0, 120.0, kSliderHeight);
        _customSlider = [[UISlider alloc] initWithFrame:frame];
        [_customSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        // in case the parent view draws with a custom color or gradient, use a transparent color
        _customSlider.backgroundColor = [UIColor clearColor];
        UIImage *stetchLeftTrack = [[UIImage imageNamed:@"orangeslide.png"]
									stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
        UIImage *stetchRightTrack = [[UIImage imageNamed:@"yellowslide.png"]
									 stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
        [_customSlider setThumbImage: [UIImage imageNamed:@"slider_ball.png"] forState:UIControlStateNormal];
        [_customSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
        [_customSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
        _customSlider.minimumValue = 0.0;
        _customSlider.maximumValue = 100.0;
        _customSlider.continuous = YES;
        _customSlider.value = 50.0;
		
		// Add an accessibility label that describes the slider.
		[_customSlider setAccessibilityLabel:NSLocalizedString(@"CustomSlider", @"")];
		
		_customSlider.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
    }
    return _customSlider;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil)
    {
        CGRect frame = CGRectMake(0.0, 14.0, 178.0, 20.0);
        _pageControl = [[UIPageControl alloc] initWithFrame:frame];
        [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventTouchUpInside];
		
        // in case the parent view draws with a custom color or gradient, use a transparent color
        _pageControl.backgroundColor = [UIColor grayColor];
        
        _pageControl.numberOfPages = 10;	// must be set or control won't draw
		
		_pageControl.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
    }
    return _pageControl;
}

- (UIActivityIndicatorView *)progressInd
{
    if (_progressInd == nil)
    {
        CGRect frame = CGRectMake(0.0, 12.0, kProgressIndicatorSize, kProgressIndicatorSize);
        
        _progressInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.progressIndSavedColor = _progressInd.color;
        _progressInd.frame = frame;
        [_progressInd sizeToFit];
        
        _progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        
		_progressInd.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
        
        [_progressInd startAnimating];
    }
    return _progressInd;
}

- (UIProgressView *)progressBar
{
    if (_progressBar == nil)
    {
        CGRect frame = CGRectMake(0.0, 20.0, kUIProgressBarWidth, kUIProgressBarHeight);
        _progressBar = [[UIProgressView alloc] initWithFrame:frame];
        _progressBar.progressViewStyle = UIProgressViewStyleDefault;
        _progressBar.progress = 0.5;
		
		_progressBar.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
    }
    return _progressBar;
}

- (UIStepper *)stepper
{
    if (_stepper == nil && [UIStepper class])
    {
        CGRect frame = CGRectMake(0.0, 10.0, 0.0, 0.0);
        _stepper = [[UIStepper alloc] initWithFrame:frame];
		[_stepper sizeToFit];        // size the control to it's normal size
        
		_stepper.tag = kViewTag;     // tag this view for later so we can remove it from recycled table cells
        _stepper.value = 0;
        _stepper.minimumValue = 0;
        _stepper.maximumValue = 10;
        _stepper.stepValue = 1;
        
        [_stepper addTarget:self action:@selector(stepperAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _stepper;
}

- (void)tintAction:(id)sender
{
    UIColor *tintColor = (self.progressBar.progressTintColor != nil) ? nil : [UIColor blueColor];

    self.progressBar.progressTintColor = tintColor;
    self.progressBar.trackTintColor = tintColor;
    self.sliderCtl.minimumTrackTintColor = tintColor;
    self.sliderCtl.thumbTintColor = tintColor;
    self.switchCtl.onTintColor = tintColor;
    self.stepper.tintColor = tintColor;
    
    UIColor *thumbTintColor = (self.switchCtl.thumbTintColor != nil) ? nil : [UIColor redColor];
    self.switchCtl.onTintColor = tintColor;
    self.switchCtl.thumbTintColor = thumbTintColor;
    
    UIColor *progressIndColor = (self.progressInd.color != self.progressIndSavedColor) ? self.progressIndSavedColor : [UIColor blueColor];
    self.progressInd.color = progressIndColor;
}

@end

