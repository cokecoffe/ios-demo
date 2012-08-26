//
//  MessageDelegate.h
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageDelegate <NSObject>

-(void)newMessageReceived:(NSDictionary *)messageContent;

@end
