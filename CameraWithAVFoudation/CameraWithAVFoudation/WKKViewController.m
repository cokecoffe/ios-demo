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
@synthesize liveImageView;
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
//    [self.liveView setTransform:CGAffineTransformMakeScale(0.8, 0.8 )];
    [self.view addSubview:self.RealView];
}

- (void)viewDidUnload
{
    [self setPreview:nil];

    [self setRealView:nil];
    [self setLiveView:nil];
    [self setLiveImageView:nil];
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
    [liveImageView release];
    [super dealloc];
}

-(void)getImage
{
    self.Preview.image = [CameraImageHelper image];
    NSLog(@"%f,%f",self.Preview.image.size.height,self.Preview.image.size.width);
}

- (IBAction)snapPressed:(id)sender {
    [CameraImageHelper CaptureStillImage];
    [self performSelector:@selector(getImage) withObject:nil afterDelay:0.5];
}

@end
