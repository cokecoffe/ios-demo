//
//  WKKAnimationViewController.m
//  UI_DEMOS
//
//  Created by wangkeke on 12-11-27.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "WKKAnimationViewController.h"

@interface WKKAnimationViewController ()

@property (retain, nonatomic) IBOutlet UIView *AnimationView;

@end



@implementation WKKAnimationViewController


- (IBAction)PageUp:(id)sender {

    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.7f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.AnimationView cache:YES];
    [UIView commitAnimations];
}

- (IBAction)PageDown:(id)sender {
    
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.7f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.AnimationView cache:YES];
    [UIView commitAnimations];
}


#pragma mark - life cycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_AnimationView release];
    [super dealloc];
}
@end
