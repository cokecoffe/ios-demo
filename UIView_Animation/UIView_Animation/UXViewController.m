//
//  UXViewController.m
//  UIView_Animation
//
//  Created by wang keke on 13-3-15.
//  Copyright (c) 2013年 uxin. All rights reserved.
//
//
//
//
//
// 此demo展示了使用ios4+的UIView基本动画
// http://www.raywenderlich.com/2454/how-to-use-uiview-animation-tutorial
//
//
//




#import "UXViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface UXViewController ()
{
    BOOL bugDead;

}
@property (weak, nonatomic) IBOutlet UIImageView *basket_Top;
@property (weak, nonatomic) IBOutlet UIImageView *basket_Bottom;

@property (weak, nonatomic) IBOutlet UIImageView *fabric_Top;
@property (weak, nonatomic) IBOutlet UIImageView *fabric_Bottom;

@property (weak, nonatomic) IBOutlet UIImageView *bug;
@end

@implementation UXViewController


- (void)viewDidAppear:(BOOL)animated
{
    
    //计算动画后上面、下面的图像各自的frame
    CGRect basketTopFrame = self.basket_Top.frame;
    basketTopFrame.origin.y = -basketTopFrame.size.height;
    
    CGRect basketBottomFrame = self.basket_Bottom.frame;
    basketBottomFrame.origin.y = self.view.bounds.size.height;

#if 0
    //ios4之前的动画调用方式
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.basket_Top.frame = basketTopFrame;
    self.basket_Bottom.frame = basketBottomFrame;
    
    [UIView commitAnimations];
#endif
    
    //移开篮子
    [UIView animateWithDuration:1.0
                          delay:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.basket_Top.frame = basketTopFrame;
                         self.basket_Bottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"动画1结束");                         
                     }];
    
    // 移开桌面
    CGRect napkinTopFrame = self.fabric_Top.frame;
    napkinTopFrame.origin.y = -napkinTopFrame.size.height;
    CGRect napkinBottomFrame = self.fabric_Bottom.frame;
    napkinBottomFrame.origin.y = self.view.bounds.size.height;
    
    [UIView animateWithDuration:1
                          delay:1.5
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.fabric_Top.frame = napkinTopFrame;
                         self.fabric_Bottom.frame = napkinBottomFrame;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"动画2结束"); 
                     }];
    
    // 左右移动虫子
    [self moveToLeft:nil finished:nil context:nil];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
//    CGRect bugRect = [self.bug frame];
    CGRect bugRect = [[[self.bug layer] presentationLayer] frame];//保证移动的时候也可以获得bug的坐标
    
    if (CGRectContainsPoint(bugRect, touchLocation)) {
        NSLog(@"Bug tapped!");
       
        bugDead = true;
        [UIView animateWithDuration:0.7
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.bug.transform = CGAffineTransformMakeScale(1.25, 0.75);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:2.0
                                                   delay:1.0
                                                 options:0
                                              animations:^{
                                                  self.bug.alpha = 0.0;
                                              } completion:^(BOOL finished) {
                                                  [self.bug removeFromSuperview];
                                              }];
                         }];
        
    } else {
        NSLog(@"Bug not tapped.");
        return;
    }
    
    // 播放声音
    NSString *squishPath = [[NSBundle mainBundle]pathForResource:@"squish" ofType:@"caf"];
    NSURL *squishURL = [NSURL fileURLWithPath:squishPath];
    SystemSoundID squishSoundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)squishURL, &squishSoundID);
    AudioServicesPlaySystemSound(squishSoundID);    
}

#pragma mark - bug animation

/*连续动画的方法*/

// Add four new methods for the bug animation
- (void)moveToLeft:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    // At the beginning of faceLeft, moveToRight, faceRight, and moveToLeft:
    if (bugDead) return;
    
    [UIView animateWithDuration:1.0
                          delay:2.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationDidStopSelector:@selector(faceRight:finished:context:)];
                         self.bug.center = CGPointMake(75, 200);
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Move to left done");
                     }];
    
}

- (void)faceRight:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    // At the beginning of faceLeft, moveToRight, faceRight, and moveToLeft:
    if (bugDead) return;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationDidStopSelector:@selector(moveToRight:finished:context:)];
                         
                         self.bug.transform = CGAffineTransformMakeRotation(M_PI);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Face right done");
                     }];
    
}

- (void)moveToRight:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
   
    // At the beginning of faceLeft, moveToRight, faceRight, and moveToLeft:
    if (bugDead) return;
    
    [UIView animateWithDuration:1.0
                          delay:2.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationDidStopSelector:@selector(faceLeft:finished:context:)];
                         self.bug.center = CGPointMake(230, 250);
                         
                     }
                     completion:^(BOOL finished){
                         
                         NSLog(@"Move to right done");
                     }];
    
}

- (void)faceLeft:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    // At the beginning of faceLeft, moveToRight, faceRight, and moveToLeft:
    if (bugDead) return;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         
                         [UIView setAnimationDidStopSelector:@selector(moveToLeft:finished:context:)];
                         self.bug.transform = CGAffineTransformMakeRotation(0);
                         
                         
                     }completion:^(BOOL finished){
                         NSLog(@"Face left done");
                         
                     }];
    
}

#pragma mark -


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
