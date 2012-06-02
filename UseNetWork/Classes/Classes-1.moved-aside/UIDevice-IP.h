//
//  UIDevice-IP.h
//  UseNetWork
//
//  Created by  vistech on 11-9-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SUPPORTS_UNDOCUMENTED_API 1

@interface UIDevice (IP)
+(NSString *)stringFromAddress:(const struct sockaddr *)address;
+(BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address;
+(NSString *)hostname;
+(NSString *)getIPAddressForHost:(NSString *)theHost;
+(NSString *)localIPAddress;
+(NSString *)localWiFiIPAddress;
+(NSString *)whatismyipdotcom;
@end
