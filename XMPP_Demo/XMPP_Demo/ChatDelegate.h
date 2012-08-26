//
//  ChatDelegate.h
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChatDelegate <NSObject>

-(void)newBuddyOnline:(NSString*)buddyName;
-(void)buddyWentOffline:(NSString*)buddyName;
-(void)didDisconnect;

@end
