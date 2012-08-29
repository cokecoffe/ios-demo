//
//  PaomaAppDelegate.h
//  Paoma
//
//  Created by  cokecoffe on 2012-8-29.
//  Copyright 2012年 tt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaomaViewController;

@interface PaomaAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PaomaViewController *viewController;

@end
