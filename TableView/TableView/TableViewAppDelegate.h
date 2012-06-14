//
//  TableViewAppDelegate.h
//  TableView
//
//  Created by xwwang on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewViewController;

@interface TableViewAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TableViewViewController *viewController;

@end
