//
//  ViewController.m
//  Pop_TableDemo
//
//  Created by wangkeke on 12-8-8.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "ViewController.h"
#import "MainTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize PopButton;

#pragma mark -
-(void)setButtonTitle:(NSString*)m_title
{
    self.PopButton.titleLabel.text = m_title;
    [popVC dismissPopoverAnimated:YES];
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPopButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)popTableview:(id)sender {
    
    MainTableViewController *tableVC = [[MainTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:tableVC];
    [navVC setDelegate:self];
    
    popVC = [[UIPopoverController alloc]initWithContentViewController:navVC];
    [popVC presentPopoverFromRect:((UIButton*)sender).frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [navVC release];
    [tableVC release];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popoverController release];
}
- (void)dealloc {
    [PopButton release];
    [super dealloc];
}
@end
