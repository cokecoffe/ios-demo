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

@end

@implementation WKKViewController
@synthesize RealView;
@synthesize liveView;
@synthesize Preview;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
    // 开始实时取景
    [CameraImageHelper startRunning];
    //self.RealView = [CameraImageHelper previewWithBounds:CGRectMake(0.0, 0.0, 329, 219)];
    [CameraImageHelper embedPreviewInView:self.liveView];
    [self.view addSubview:self.RealView];
    
    
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
    [self.liveView addSubview:bt];
}

- (void)viewDidUnload
{
    [self setPreview:nil];

    [self setRealView:nil];
    [self setLiveView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   // return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)==YES)
    {
        [CameraImageHelper changePreviewOrientation:(UIInterfaceOrientation)interfaceOrientation];
        return YES;
    }
    else 
    {
        return NO;
    }
}

- (void)dealloc {
    [Preview release];
    [RealView release];
    [liveView release];
    [super dealloc];
}

- (IBAction)snapPressed:(id)sender {
    self.Preview.image = [CameraImageHelper image];
    NSLog(@"%f,%f",self.Preview.image.size.height,self.Preview.image.size.width);
}

@end
