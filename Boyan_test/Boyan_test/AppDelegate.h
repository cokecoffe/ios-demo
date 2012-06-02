//
//  AppDelegate.h
//  Boyan_test
//
//  Created by 可可 王 on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *NavVC;
}

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *NavVC;

@end
