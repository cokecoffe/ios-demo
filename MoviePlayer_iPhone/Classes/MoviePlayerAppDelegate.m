/*
     File: MoviePlayerAppDelegate.m
 Abstract:  A simple UIApplication delegate class that adds the MyMovieViewController
view to the window as a subview. 
Also sets the application settings based on the defaults in the application
bundle.

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

#import "MoviePlayerAppDelegate.h"

NSString *kScalingModeKey	= @"scalingMode";
NSString *kControlModeKey	= @"controlMode";
NSString *kBackgroundColorKey	= @"backgroundColor";

@implementation MoviePlayerAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize moviePlayer;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	

    // Override point for customization after app. launch

    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];

    [window makeKeyAndVisible];

	// Register to receive a notification that the movie is now in memory and ready to play
	[[NSNotificationCenter defaultCenter] addObserver:self 
					 selector:@selector(moviePreloadDidFinish:) 
					 name:MPMoviePlayerContentPreloadDidFinishNotification 
					 object:nil];

	// Register to receive a notification when the movie has finished playing. 
	[[NSNotificationCenter defaultCenter] addObserver:self 
					selector:@selector(moviePlayBackDidFinish:) 
					name:MPMoviePlayerPlaybackDidFinishNotification 
					object:nil];

	// Register to receive a notification when the movie scaling mode has changed. 
	[[NSNotificationCenter defaultCenter] addObserver:self 
					selector:@selector(movieScalingModeDidChange:) 
					name:MPMoviePlayerScalingModeDidChangeNotification 
					object:nil];
}

-(void)initAndPlayMovie:(NSURL *)movieURL
{
	// Initialize a movie player object with the specified URL
	MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
	if (mp)
	{
		// save the movie player object
		self.moviePlayer = mp;
		[mp release];
		
		// Apply the user specified settings to the movie player object
		[self setMoviePlayerUserSettings];
		
		// Play the movie!
		[self.moviePlayer play];
	}
}

-(void)setMoviePlayerUserSettings
{
    /* First get the movie player settings defaults (scaling, controller type and background color)
	 set by the user via the built-in iPhone Settings application */
	 
    NSString *testValue = [[NSUserDefaults standardUserDefaults] stringForKey:kScalingModeKey];
    if (testValue == nil)
    {
        // No default movie player settings values have been set, create them here based on our 
        // settings bundle info.
        //
        // The values to be set for movie playback are:
        //
        //    - scaling mode (None, Aspect Fill, Aspect Fit, Fill)
        //    - controller mode (Standard Controls, Volume Only, Hidden)
        //    - background color (Any UIColor value)
        //
        
        NSString *pathStr = [[NSBundle mainBundle] bundlePath];
        NSString *settingsBundlePath = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
        NSString *finalPath = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
        
        NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSArray *prefSpecifierArray = [settingsDict objectForKey:@"PreferenceSpecifiers"];
        
        NSNumber *controlModeDefault;
        NSNumber *scalingModeDefault;
        NSNumber *backgroundColorDefault;
        
        NSDictionary *prefItem;
        for (prefItem in prefSpecifierArray)
        {
            NSString *keyValueStr = [prefItem objectForKey:@"Key"];
            id defaultValue = [prefItem objectForKey:@"DefaultValue"];
            
            if ([keyValueStr isEqualToString:kScalingModeKey])
            {
                scalingModeDefault = defaultValue;
            }
            else if ([keyValueStr isEqualToString:kControlModeKey])
            {
                controlModeDefault = defaultValue;
            }
            else if ([keyValueStr isEqualToString:kBackgroundColorKey])
            {
                backgroundColorDefault = defaultValue;
            }
        }
        
        // since no default values have been set, create them here
        NSDictionary *appDefaults =  [NSDictionary dictionaryWithObjectsAndKeys:
                                      scalingModeDefault, kScalingModeKey,
                                      controlModeDefault, kControlModeKey,
                                      backgroundColorDefault, kBackgroundColorKey,
                                      nil];
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    /* Now apply these settings to the active Movie Player (MPMoviePlayerController) object  */

    /* 
        Movie scaling mode can be one of: MPMovieScalingModeNone, MPMovieScalingModeAspectFit,
            MPMovieScalingModeAspectFill, MPMovieScalingModeFill.
   */
    self.moviePlayer.scalingMode = [[NSUserDefaults standardUserDefaults] integerForKey:kScalingModeKey];
    
    /* 
        Movie control mode can be one of: MPMovieControlModeDefault, MPMovieControlModeVolumeOnly,
            MPMovieControlModeHidden.
   */
    self.moviePlayer.movieControlMode = [[NSUserDefaults standardUserDefaults] integerForKey:kControlModeKey];

    /*
        The color of the background area behind the movie can be any UIColor value.
    */
    UIColor *colors[15] = {[UIColor blackColor], [UIColor darkGrayColor], [UIColor lightGrayColor], [UIColor whiteColor], 
        [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], 
        [UIColor yellowColor], [UIColor magentaColor],[UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor], 
        [UIColor clearColor]};
	self.moviePlayer.backgroundColor = colors[ [[NSUserDefaults standardUserDefaults] integerForKey:kBackgroundColorKey] ];

	/*
		The time relative to the duration of the video when playback should start, if possible. 
		Defaults to 0.0. When set, the closest key frame before the provided time will be used as the 
		starting frame.
	self.moviePlayer.initialPlaybackTime = <specify a movie time here>;
	
	*/
}

//  Notification called when the movie finished preloading.
 - (void) moviePreloadDidFinish:(NSNotification*)notification
 {
     /* 
       < add your code here >
	   
            MPMoviePlayerController* moviePlayerObj=[notification object];
            etc.
    */
 }

//  Notification called when the movie finished playing.
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    /*     
        < add your code here >
        
            MPMoviePlayerController* moviePlayerObj=[notification object];
            etc.
    */
}

//  Notification called when the movie scaling mode has changed.
- (void) movieScalingModeDidChange:(NSNotification*)notification
{
    /* 
        < add your code here >
        
            MPMoviePlayerController* moviePlayerObj=[notification object];
            etc.
    */
}


- (void)dealloc {
    [window release];
	
    // remove all movie notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerContentPreloadDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerScalingModeDidChangeNotification
                                                  object:nil];
	// remove notification for touches to overlay view
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:OverlayViewTouchNotification
                                                  object:nil];
	[moviePlayer release]; 
		
    [super dealloc];
}


@end
