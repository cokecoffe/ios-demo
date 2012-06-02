//
//  UseNetWorkAppDelegate.h
//  UseNetWork
//
//  Created by  vistech on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@class UseNetWorkViewController;

@interface UseNetWorkAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigation;
	UseNetWorkViewController *viewController;
	Reachability *hostReach;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UseNetWorkViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigation;
@end

