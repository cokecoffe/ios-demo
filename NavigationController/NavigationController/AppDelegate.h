//
//  AppDelegate.h
//  NavigationController
//
//  Created by 可可 王 on 12-6-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navVC;
}

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *navVC;

@end
