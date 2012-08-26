//
//  ViewController.h
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatDelegate.h"

@interface BuddyListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ChatDelegate>
{
    NSMutableArray *onlineBuddies;//在线好友
    __weak IBOutlet UITableView *buddyTableView;
}
- (IBAction)showLogin:(id)sender;//显示登陆界面

@end
