//
//  ChatViewController.h
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDelegate.h"

@interface ChatViewController : UIViewController <MessageDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString *chatWithUser;
    NSMutableArray *messages;
}

@property (strong,nonatomic) NSString *chatWithUser;
@property (weak, nonatomic) IBOutlet UITableView *ChatTableView;
@property (weak, nonatomic) IBOutlet UITextField *messageField;


- (IBAction)CloseChat:(id)sender;
- (IBAction)SendMessage;

-(id)initWithUser:(NSString*)userName;
@end
