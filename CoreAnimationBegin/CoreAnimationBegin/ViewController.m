//
//  ViewController.m
//  CoreAnimationBegin
//
//  Created by 可可 王 on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize boxView;

-(void)loadView
{
    [super loadView];
    scaleFactor = 2;
    angle = 180;
    CGRect frameRect = CGRectMake(10, 10, 100, 100);
    boxView = [[UIView alloc] initWithFrame:frameRect];
    boxView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:boxView];
}

-(void)dealloc{
    [boxView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.boxView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGAffineTransform scaleTrans = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    CGAffineTransform rotateTrans = CGAffineTransformMakeRotation(angle * M_PI / 180);
    self.boxView.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
    angle = (angle == 180 ? 360 : 180);
    scaleFactor = (scaleFactor == 2 ? 1 : 2);
    self.boxView.center = location;
    [UIView commitAnimations];
    
}

@end
