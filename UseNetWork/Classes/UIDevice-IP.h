//
//  UIDevice-IP.h
//  UseNetWork
//
//  Created by  vistech on 11-9-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <net/if.h>
#import <ifaddrs.h>


@interface UIDevice (IP)
+(BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address;
+(NSString *)getIPAddressForHost:(NSString *)host;
+(BOOL)hostAvailable:(NSString *)theHost;

@end
