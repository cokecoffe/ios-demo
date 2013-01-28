//
//  ViewController.m
//  SwitchControllerDemo
//
//  Created by 可可 王 on 12-3-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize yellow_controller;
@synthesize blue_controller;

-(IBAction)switchViews:(id)sender
{
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if (self->curView == BLUE) 
    {

        
        [self.blue_controller.view removeFromSuperview];
        [self.view insertSubview:self.yellow_controller.view atIndex:0];
        self->curView = YELLOW;
    }
    else 
    {
        //动画翻页
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.blue_controller viewWillAppear:YES];
        [self.yellow_controller viewWillDisappear:YES];

        [self.yellow_controller.view removeFromSuperview];
        [self.view insertSubview:self.blue_controller.view atIndex:0];
        
        [self.yellow_controller viewWillDisappear:YES];
        [self.blue_controller viewWillAppear:YES];        
        
        self->curView = BLUE;
    }
    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    BlueViewController *bluecontroller = [[BlueViewController alloc]initWithNibName:@"BlueViewController" bundle:nil];
    self.blue_controller = bluecontroller;
    
    self.yellow_controller = [[YellowViewController alloc]initWithNibName:@"YellowViewController" bundle:nil];
    
    [self.view insertSubview:bluecontroller.view atIndex:0];
    self->curView = BLUE;
    
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

@end
