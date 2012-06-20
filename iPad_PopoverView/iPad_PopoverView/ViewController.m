//
//  ViewController.m
//  iPad_PopoverView
//
//  Created by Wang keke on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize popContentVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void)dealloc
{
    [popContentVC release];
    [super dealloc];
}
- (IBAction)Configure:(id)sender
{
    if (popoverVC == nil) {
        popoverVC = [[UIPopoverController alloc]initWithContentViewController:popContentVC];
    }
    [popoverVC presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    popoverVC.delegate = self;
}

#pragma mark
#pragma mark Popover Delegate

/*弹出框消失会回调此函数*/
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (popContentVC.a_switch.on) 
    {
        popContentVC.a_switch.on = NO;
    }
    else 
    {
        popContentVC.a_switch.on = YES;
    }
    
    [popoverVC release];
     popoverVC = nil;
}

@end
