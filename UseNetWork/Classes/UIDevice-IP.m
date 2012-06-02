//
//  UIDevice-IP.m
//  UseNetWork
//
//  Created by  vistech on 11-9-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIDevice-IP.h"


@implementation UIDevice (IP)
+(BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address{
	if (!IPAddress || ![IPAddress length]) {
		return NO;
	}
	
	memset((char *)address, sizeof(struct sockaddr_in),0);
	address->sin_family = AF_INET;
	address->sin_len = sizeof(struct sockaddr_in);
	
	int conversionResult = inet_aton([IPAddress UTF8String], &address->sin_addr);
	if (conversionResult == 0) {
		NSAssert1(conversionResult = 1,@"Failed to convert the IP address string into a sockaddr_in;%@",IPAddress);
		return NO;
	}
	return YES;
}

+(NSString *)getIPAddressForHost:(NSString *)theHost{
	struct hostent *host = gethostbyname([theHost UTF8String]);
	if (!host) {
		herror("resolv");
		return NULL;
	}
	
	struct in_addr **list = (struct in_addr **)host->h_addr_list;
	NSString *addressString = [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
	return addressString;

}   
+(BOOL)hostAvailable:(NSString *)theHost{
	NSString *addressString = [self getIPAddressForHost:theHost];
	if (!addressString) {
		printf("Error recovering IP address from host name\n");
		return NO;
	}
	struct sockaddr_in address;
	BOOL gotAddress = [self addressFromString:addressString address:theHost];
	if (!gotAddress) {
		printf("Error recovering sockaddr address from %s\n",[addressString UTF8String]);
		return NO;
	}
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&address);
	SCNetworkReachabilityFlags flags;
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	if (!didRetrieveFlags) {
		printf("Error Could not recover network reachablility flags\n");
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	return isReachable ? YES:NO;
}



@end
