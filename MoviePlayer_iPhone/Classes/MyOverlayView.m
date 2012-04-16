/*
     File: MyOverlayView.m
 Abstract: A UIView subclass that is added as a subview to the movie player
 window. This view and its associated controls will display on 
 top of the movie window and receive any touch events while the 
 movie plays underneath it.
 
  Version: 1.3
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2009 Apple Inc. All Rights Reserved.
 
 */

#import "MyOverlayView.h"
#import "MyMovieViewController.h"

@implementation MyOverlayView

// MPMoviePlayerController will play movies full-screen in 
// landscape mode, so we must rotate MyOverlayView 90 degrees and 
// translate it to the center of the screen so when it draws
// on top of the playing movie it will display in landscape 
// mode to match the movie player orientation.
//
- (void)awakeFromNib
{
	CGAffineTransform transform = self.transform;

	// Rotate the view 90 degrees. 
	transform = CGAffineTransformRotate(transform, (M_PI / 2.0));

    UIScreen *screen = [UIScreen mainScreen];
    // Translate the view to the center of the screen
    transform = CGAffineTransformTranslate(transform, 
        ((screen.bounds.size.height) - (self.bounds.size.height))/2, 
        0);
	self.transform = transform;
	
	CGRect newFrame = self.frame;
	newFrame.origin.x = 190;
	self.frame = newFrame;
}

- (void)dealloc {
	[super dealloc];
}

// Handle any touches to the overlay view
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    if (touch.phase == UITouchPhaseBegan)
    {
        // IMPORTANT:
        // Touches to the overlay view are being handled using
        // two different techniques as described here:
        //
        // 1. Touches to the overlay view (not in the button)
        //
        // On touches to the view we will post a notification
        // "overlayViewTouch". MyMovieViewController is registered 
        // as an observer for this notification, and the 
        // overlayViewTouches: method in MyMovieViewController
        // will be called. 
        //
        // 2. Touches to the button 
        //
        // Touches to the button in this same view will 
        // trigger the MyMovieViewController overlayViewButtonPress:
        // action method instead.

        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:OverlayViewTouchNotification object:nil];

    }    
}


@end
