//
//  WKKViewController.m
//  CameraWithAVFoudation
//
//  Created by 可可 王 on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WKKViewController.h"
#import "CameraImageHelper.h"

@interface WKKViewController ()
@property(retain,nonatomic) CameraImageHelper *CameraHelper;
@end

@implementation WKKViewController
@synthesize RealView;
@synthesize liveView;
@synthesize Preview;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
    _CameraHelper = [[CameraImageHelper alloc]init];
    
    // 开始实时取景
    [_CameraHelper startRunning];
    [_CameraHelper embedPreviewInView:self.liveView];

    [_CameraHelper changePreviewOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    [self.view addSubview:self.RealView];
}

- (void)viewDidUnload
{
    [self setPreview:nil];

    [self setRealView:nil];
    [self setLiveView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_CameraHelper changePreviewOrientation:(UIInterfaceOrientation)toInterfaceOrientation];
}

- (void)dealloc {
    [Preview release];
    [RealView release];
    [liveView release];
    [super dealloc];
}

-(void)getImage
{
    self.Preview.image = [_CameraHelper image];
    NSLog(@"%f,%f",self.Preview.image.size.height,self.Preview.image.size.width);
}

- (IBAction)snapPressed:(id)sender {
    [_CameraHelper CaptureStillImage];
    [self performSelector:@selector(getImage) withObject:nil afterDelay:0.5];
}

@end
