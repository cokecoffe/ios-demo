//
//  AppDelegate.h
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"
#import "ChatDelegate.h"
#import "MessageDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,XMPPStreamDelegate>
{
    XMPPStream *xmppStream;
    NSString *password;
    BOOL isOpen;
    
    
    __weak id <ChatDelegate> chatDelegate;
    __weak id <MessageDelegate> messageDelegate;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong,readonly) XMPPStream *xmppStream;

@property(nonatomic,weak) id<ChatDelegate> chatDelegate;
@property(nonatomic,weak) id<MessageDelegate> messageDelegate;;

-(BOOL)connect;
-(void)disconnect;

@end
