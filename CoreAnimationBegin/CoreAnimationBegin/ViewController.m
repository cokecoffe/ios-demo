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

- (IBAction)shake:(id)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    animation.additive = YES;//在原基础上改变value
    
    [self.photoIMG.layer addAnimation:animation forKey:@"shake"];
}

- (IBAction)path:(id)sender {
    CGRect boundingRect = CGRectMake(-64, -64, 128, 128);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    orbit.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    [self.photoIMG.layer addAnimation:orbit forKey:@"orbit"];
}

- (IBAction)card:(id)sender {
    //z postion
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    //rotation
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[ @0, @0.14, @0 ];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    //postion
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[
                        [NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(60, -20)],
                        [NSValue valueWithCGPoint:CGPointZero]
                        ];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    position.additive = YES;
    position.duration = 1.2;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[zPosition,rotation,position];
    group.duration = 1.2;
    
    [self.photoIMG.layer addAnimation:group forKey:@"shuffle"];
    
    self.photoIMG.layer.zPosition = 1;
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
