//
//  AppDelegate.h
//  UIsplitView
//
//  Created by 可可 王 on 12-5-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class DetailViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UISplitViewController *splitVC;
    RootViewController *rootVC;
    DetailViewController *detailVC;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) IBOutlet UISplitViewController *splitVC;
@property (nonatomic,retain) IBOutlet RootViewController *rootVC;
@property (nonatomic,retain) IBOutlet DetailViewController *detailVC;

@end
