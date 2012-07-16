//
//  CameraImageHelper.m
//  HelloWorld
//
//  Created by Erica Sadun on 7/21/10.
//  Copyright 2010 Up To No Good, Inc. All rights reserved.
//

#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import "CameraImageHelper.h"

@implementation CameraImageHelper
@synthesize session,image,g_orientation;
@synthesize preview;

static CameraImageHelper *sharedInstance = nil;

//实时采集
- (void)captureOutput:(AVCaptureOutput *)captureOutput 
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer 
       fromConnection:(AVCaptureConnection *)connection
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer); 
    CVPixelBufferLockBaseAddress(imageBuffer,0); 
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer); 
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
    size_t width = CVPixelBufferGetWidth(imageBuffer); 
    size_t height = CVPixelBufferGetHeight(imageBuffer); 
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst); 
    CGImageRef newImage = CGBitmapContextCreateImage(context); 
	CVPixelBufferUnlockBaseAddress(imageBuffer,0);
	
    self.image = [UIImage imageWithCGImage:newImage scale:1.0 orientation:g_orientation];
	
    CGContextRelease(context); 
    CGColorSpaceRelease(colorSpace);
	CGImageRelease(newImage);
    
	[pool drain];
}

- (void) initialize
{
    //1.创建会话层
    self.session = [[[AVCaptureSession alloc] init] autorelease];
    
    
    //2.创建、配置输入设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	NSError *error;
	AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
	if (!captureInput)
	{
		NSLog(@"Error: %@", error);
		return;
	}
    [self.session addInput:captureInput];
    
    
    //3.创建、配置输出    
	dispatch_queue_t queue = dispatch_queue_create("MyQueue", NULL);
	AVCaptureVideoDataOutput *captureOutput = [[[AVCaptureVideoDataOutput alloc] init] autorelease];
	captureOutput.alwaysDiscardsLateVideoFrames = YES; 
	[captureOutput setSampleBufferDelegate:self queue:queue];
	// dispatch_release(queue); // Will not work when uncommented -- apparently reference count is altered by setSampleBufferDelegate:queue:
    
	
	NSDictionary *settings = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA] 
                                                         forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
	[captureOutput setVideoSettings:settings];

	[self.session addOutput:captureOutput];
}

- (id) init
{
	if (self = [super init]) [self initialize];
	return self;
}

- (UIView *) previewWithBounds: (CGRect) bounds
{
	UIView *view = [[[UIView alloc] initWithFrame:bounds] autorelease];
	
	preview = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
	preview.frame = bounds;
	preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.orientation = UIInterfaceOrientationLandscapeRight;
    
	[view.layer addSublayer: preview];
	
	return view;
}

-(void) embedPreviewInView: (UIView *) aView {
    if (!session) return;
    
    preview = [AVCaptureVideoPreviewLayer layerWithSession: session];
    preview.frame = aView.bounds;
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill; 
    [aView.layer addSublayer: preview];
}

- (void)changePreviewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     [CATransaction begin];
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        g_orientation = UIImageOrientationUp;
        preview.orientation = AVCaptureVideoOrientationLandscapeRight;
        
    }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        g_orientation = UIImageOrientationDown;
        preview.orientation = AVCaptureVideoOrientationLandscapeLeft;
    }
    [CATransaction commit];
}

- (void) dealloc
{
	self.session = nil;
	self.image = nil;
	[super dealloc];
}

#pragma mark Class Interface

+ (id) sharedInstance // private
{
	if(!sharedInstance) sharedInstance = [[self alloc] init];
    return sharedInstance;
}

+ (void) startRunning
{
	[[[self sharedInstance] session] startRunning];	
}

+ (void) stopRunning
{
	[[[self sharedInstance] session] stopRunning];
}

+ (UIImage *) image
{
	return [[self sharedInstance] image];
}

+ (UIView *) previewWithBounds: (CGRect) bounds
{
	return [[self sharedInstance] previewWithBounds: (CGRect) bounds];
}

+ (void)embedPreviewInView: (UIView *) aView
{
    [[self sharedInstance] embedPreviewInView:aView];
}

+ (void)changePreviewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [[self sharedInstance] changePreviewOrientation:(UIInterfaceOrientation)interfaceOrientation];
}

@end
