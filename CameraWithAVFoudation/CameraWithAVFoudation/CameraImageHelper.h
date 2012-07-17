//
//  CameraImageHelper.h
//  HelloWorld
//
//  Created by Erica Sadun on 7/21/10.
//  Copyright 2010 Up To No Good, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CameraImageHelper : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>
{
	AVCaptureSession *session;
    AVCaptureStillImageOutput *captureOutput;
	UIImage *image;
    AVCaptureVideoPreviewLayer *preview;
    UIImageOrientation g_orientation;
}
@property (retain) AVCaptureSession *session;
@property (retain) AVCaptureOutput *captureOutput;
@property (retain) UIImage *image;
@property (assign) UIImageOrientation g_orientation;
@property (assign) AVCaptureVideoPreviewLayer *preview;

+ (void) startRunning;
+ (void) stopRunning;
+ (UIImage *) image;

+ (void)embedPreviewInView: (UIView *) aView;
+(void)CaptureStillImage;
+ (void)changePreviewOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
