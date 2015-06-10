//
//  CapturePauseViewController.m
//  CapturePause
//
//  Created by Geraint Davies on 27/02/2013.
//  Copyright (c) 2013 Geraint Davies. All rights reserved.
//

#import "CapturePauseViewController.h"
#import "CameraEngine.h"

@interface CapturePauseViewController ()

@end

@implementation CapturePauseViewController

@synthesize cameraView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startPreview];
}

- (void) startPreview
{
    AVCaptureVideoPreviewLayer* preview = [[CameraEngine engine] getPreviewLayer];
    [preview removeFromSuperlayer];
    preview.frame = self.cameraView.bounds;
    [[preview connection] setVideoOrientation:UIInterfaceOrientationLandscapeRight];
    
    [self.cameraView.layer addSublayer:preview];
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // this is not the most beautiful animation...
    AVCaptureVideoPreviewLayer* preview = [[CameraEngine engine] getPreviewLayer];
    preview.frame = self.cameraView.bounds;
    [[preview connection] setVideoOrientation:toInterfaceOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRecording:(id)sender
{
    [[CameraEngine engine] startCapture];
}

- (IBAction)pauseRecording:(id)sender
{
    [[CameraEngine engine] pauseCapture];
}

- (IBAction)stopRecording:(id)sender
{
    [[CameraEngine engine] stopCapture];
}
- (IBAction)resumeRecording:(id)sender
{
    [[CameraEngine engine] resumeCapture];
}

@end
