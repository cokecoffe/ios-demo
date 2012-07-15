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
	UIImage *image;
    AVCaptureVideoPreviewLayer *preview;
    UIImageOrientation g_orientation;
}
@property (retain) AVCaptureSession *session;
@property (retain) UIImage *image;
@property (assign) UIImageOrientation g_orientation;
@property (assign) AVCaptureVideoPreviewLayer *preview;

+ (void) startRunning;
+ (void) stopRunning;
+ (UIImage *) image;

+ (UIView *) previewWithBounds: (CGRect) bounds;
+ (void)embedPreviewInView: (UIView *) aView;
+ (void)changePreviewOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
