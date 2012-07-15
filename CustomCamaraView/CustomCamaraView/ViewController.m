//
//  ViewController.m
//  CustomCamaraView
//
//  Created by Wang keke on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "OverlayView.h"

//transform values for full screen support
#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1.12412
//iphone screen dimensions
#define SCREEN_WIDTH  1024
#define SCREEN_HEIGTH 768

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)catch:(id)sender 
{
    //create an overlay view instance
    OverlayView *overlay = [[OverlayView alloc]
                            initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
    
    //create a new image picker instance
    picker =[[UIImagePickerController alloc] init];
    //set source to video!
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //hide all controls
    picker.showsCameraControls = NO;
    picker.navigationBarHidden = YES;
    picker.toolbarHidden = YES;
    //make the video preview full size
    picker.wantsFullScreenLayout = YES;
    picker.cameraViewTransform =
    CGAffineTransformScale(picker.cameraViewTransform,
                           CAMERA_TRANSFORM_X,
                           CAMERA_TRANSFORM_Y);
    //set our custom overlay view
    picker.cameraOverlayView = overlay;
    
    //show picker
    [self presentModalViewController:picker animated:YES];
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
    [picker release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        return NO;
    }
  
    CGAffineTransform transform = picker.cameraOverlayView.transform;
    transform = CGAffineTransformRotate(transform, 1);
    [picker.cameraOverlayView setTransform:transform];
  

    return YES;
}

@end
