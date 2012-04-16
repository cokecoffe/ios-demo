/*
     File: AppDelegate.m 
 Abstract: The application delegate class used for installing our navigation controller. 
  Version: 2.10 
  
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
  
 Copyright (C) 2011 Apple Inc. All Rights Reserved. 
  
 */

#import "AppDelegate.h"
#import "MainViewController.h"

// Note about Info.plist:
//
// If you want the status bar to be hidden at launch use this:
//		application.statusBarHidden = YES;
//
// or in your info.plist use:
//		<key>UIStatusBarHidden</key>
//		<true/>
//
// If you want your status bar a particular color at launch use this:
//		<key>UIStatusBarStyle</key>
//		<string>UIStatusBarStyleBlackOpaque</string>
//
// also if you don't want your app icon to be post-rendered with rounded corners and with a shine use
//		<key>UIPrerenderedIcon</key>
//		<true/>
//

@implementation AppDelegate

@synthesize window, navigationController;

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	// low on memory: do whatever you can to reduce your memory foot print here
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	// To set the status bar as black, use the following:
	// application.statusBarStyle = UIStatusBarStyleBlackOpaque;

	// this helps in debugging, so that you know "exactly" where your views are placed;
	// if you see "red", you are looking at the bare window, otherwise use black
	// window.backgroundColor = [UIColor redColor];
	
	// add the navigation controller's view to the window
	[window addSubview: navigationController.view];
	[window makeKeyAndVisible];
}

- (void)dealloc
{
	[navigationController release];
    [window release];    
    [super dealloc];
}

@end


