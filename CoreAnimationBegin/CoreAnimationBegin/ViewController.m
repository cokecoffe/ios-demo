//
//  ViewController.m
//  CoreAnimationBegin
//
//  Created by 可可 王 on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (retain, nonatomic) IBOutlet UIImageView *photoIMG;

@property (retain, nonatomic) IBOutlet UISwitch *fromValueSwitch;
@property (retain, nonatomic) IBOutlet UISwitch *byValueSwitch;
@property (retain, nonatomic) IBOutlet UISwitch *toValueSwitch;

@end

@implementation ViewController

#pragma mark - core animation action

- (IBAction)basicAnimation:(id)sender {
    
    //Init position(160,180)
    
    //create animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    
    if (_fromValueSwitch.on) {
        animation.fromValue = @(180);
    }
    
    if (_byValueSwitch.on) {
        animation.byValue = @(50);
    }
    
    if (_toValueSwitch.on) {
        animation.toValue =  @(300);
    }
    
    animation.duration = 1.0;
    //set animation to layer
    [self.photoIMG.layer addAnimation:animation forKey:@"basic"];
    
    //update the model layer
    self.photoIMG.layer.position = CGPointMake(160, 300);
}

#pragma mark - life cycle

-(void)loadView
{
    [super loadView];
}

-(void)dealloc{
    [_fromValueSwitch release];
    [_byValueSwitch release];
    [_toValueSwitch release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPhotoIMG:nil];
    [self setFromValueSwitch:nil];
    [self setByValueSwitch:nil];
    [self setToValueSwitch:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
