//
//  SQLiteSampleAppDelegate.m
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import "SQLiteSampleAppDelegate.h"
#import "ViewController.h"


@implementation SQLiteSampleAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{		
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	ViewController *controller = [[ViewController alloc] init];
	
    [window setRootViewController:controller];
	[window makeKeyAndVisible];
}

- (void)dealloc {
	[window release];
	[super dealloc];
}

@end