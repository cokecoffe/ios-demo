//
//  UIDevice-IP.m
//  UseNetWork
//
//  Created by  vistech on 11-9-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIDevice-IP.h"
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>

@implementation UIDevice (IP)
+(NSString *)stringFromAddress:(const struct sockaddr *)address{
	if (address && address->sa_family == AF_INET) {
		const struct sockaddr_in* sin = (struct sockaddr_in *)address;
		return [NSString stringWithFormat:@"%@:%d",[NSString stringWithUTF8String:inet_ntoa(sin->sin_addr)],ntohs(sin->sin_port)];
	}
	return nil;
}

+(BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address{
	if (!IPAddress || [IPAddress length]) {
		return NO;
	}
	
	memset((char *)address,sizeof(struct sockaddr_in),0);
	address->sin_family = AF_INET;
	address->sin_len = sizeof(struct sockaddr_in);
	
	int conversionResult = inet_aton([IPAddress UTF8String],&address->sin_addr);
	if (conversionResult == 0) {
		NSAssert1(conversionResult != 1,@"Failed to convert the IP Address string into a sockaddr_in:%@",IPAddress);
		return NO;
	}
	return YES;
}

+(NSString *)hostname{
	char baseHostName[256];
	int success = gethostname(baseHostName,255);
	if (success != 0 ) {
		return nil;
	}
	baseHostName[255] = '\0';
#if !TARGET_IPHONE_SIMULATOR
	return [NSString stringWithFormat:@"%s.local",baseHostName];
#else
	return [NSString stringWithFormat:@"%s",baseHostName];
#endif
}

+(NSString *)getIPAddressForHost:(NSString *)theHost{
	struct hostent *host = gethostbyname([theHost UTF8String]);
	if (!host) {
		herror("resolv");
		return NULL;
	}
	struct in_addr **list = (struct in_addr **)host->h_addr_list;
	return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
	
}

+(NSString *)localIPAddress{
	struct hostent *host = gethostbyname([[self hostname] UTF8String]);
	if (!host) {
		herror("resolv");
		return nil;
	}
	
	struct in_addr **list = (struct in_addr **)host->h_addr_list;
	return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
}

+(NSString *)localWiFiIPAddress{
	BOOL success;
	struct ifaddrs * addrs;
	const struct ifaddrs * cursor;
	success = getifaddrs(&addrs) == 0;
	if (success) {
		cursor = addrs;
		while (cursor != NULL) {
			if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0) {
				NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
				if([name isEqualToString:@"en0"]){
					return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
				}
			}
			cursor = cursor->ifa_next;
		}
		freeifaddrs(addrs);
	}
	return nil;
}

+(NSString *)whatismyipdotcom{
	NSError *error;
	NSURL *ipURL = [NSURL URLWithString:@"http://www.whatismyip.com/automation/n09230945.asp"];
	NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
	return ip? ip:[error localizedDescription];
}
@end
