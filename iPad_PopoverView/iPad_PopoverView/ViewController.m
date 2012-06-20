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
@synthesize ContentToolVC;
@synthesize ContentTableVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setContentTableVC:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void)dealloc
{
    [ContentToolVC release];
    [ContentTableVC release];
    [super dealloc];
}
- (IBAction)Configure:(id)sender
{
    if (popToolVC == nil) 
    {
        popToolVC = [[UIPopoverController alloc]initWithContentViewController:ContentToolVC];
        [popToolVC presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        popToolVC.delegate = self;
    }
}

#pragma mark
#pragma mark Popover Delegate

/*弹出框消失会回调此函数*/
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    
    if (popoverController == popToolVC) 
    {
        if (ContentToolVC.a_switch.on) 
        {
            ContentToolVC.a_switch.on = NO;
        }
        else 
        {
            ContentToolVC.a_switch.on = YES;
        }
        
        [popToolVC release];
        popToolVC = nil;
    }
    else if(popoverController == popTableVC)
    {
        [popTableVC release];
        popTableVC = nil;
    }
}

- (IBAction)PopTable:(id)sender
{
    if (popTableVC == nil)
    {
        popTableVC = [[UIPopoverController alloc]initWithContentViewController:ContentTableVC];
        [popTableVC presentPopoverFromRect:((UIButton*)sender).frame inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        popTableVC.delegate = self;
    }
}
@end
