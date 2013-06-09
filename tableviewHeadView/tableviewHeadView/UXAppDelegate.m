//
//  UXAppDelegate.m
//  tableviewHeadView
//
//  Created by keke Wang on 13-5-9.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

#import "UXAppDelegate.h"
#import "UXTableViewController.h"
@implementation UXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UXTableViewController *tableVC = [[UXTableViewController alloc]initWithNibName:@"UXTableViewController" bundle:nil];
    self.window.rootViewController = tableVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
