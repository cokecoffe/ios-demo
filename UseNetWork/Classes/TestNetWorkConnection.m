//
//  TestNetWorkConnection.m
//  UseNetWork
//
//  Created by  vistech on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestNetWorkConnection.h"
#import<SystemConfiguration/SystemConfiguration.h>
#import<netdb.h>

@implementation TestNetWorkConnection
@synthesize hostReach;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)viewDidLoad{
	
	
}

-(BOOL)connectedToNetWork
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags) {
		printf("Error. Count not recover network reachability flags\n");
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	return (isReachable && !needsConnection) ? YES : NO;
}


-(void)buttonPressed:(id)sender{
	NSString *result;
	if ([self connectedToNetWork]) {
		result = @"Connection Successed!!!";
	}else {
		result = @"Connection Faild!!!";
	}
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TestConnection" message:result
												   delegate:self
										  cancelButtonTitle:@"OK,I Know" otherButtonTitles:nil];
	[alert show];
	[alert release];

}

-(void)testNetWorkKind:(id)sender{
	NSString *connectionKind;
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
	switch ([hostReach currentReachabilityStatus]) {
		case NotReachable:
			connectionKind = @"没有网络链接";
			break;
		case ReachableViaWiFi:
			connectionKind = @"当前使用的网络类型是WIFI";
			break;
		case ReachableViaWWAN:
			connectionKind = @"当前使用的网络链接类型是WWAN（3G）";
			break;
		default:
			break;
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络链接类型" message:connectionKind
												   delegate:self
										  cancelButtonTitle:@"知道了，谢谢" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

	
-(void)viewWillAppear:(BOOL)animated{
	//查看当前可用网络环境
	NSString *cannUseNetWork;
	if ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable) {
		cannUseNetWork = @"Wifi";
	}
	else if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable){
		cannUseNetWork = @"3G";
	}
	NSLog(@"%@",cannUseNetWork);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[hostReach release];
    [super dealloc];
}


@end
