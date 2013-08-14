//
//  MyLocalTimeSoapAppDelegate.h
//  MyLocalTimeSoap
//
//  Created by Vincent on 10-10-24.
//  Copyright DevDiv Community 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyLocalTimeSoapViewController;

@interface MyLocalTimeSoapAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MyLocalTimeSoapViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MyLocalTimeSoapViewController *viewController;

@end

