//
//  TestBed.m
//  UseNetWork
//
//  Created by  vistech on 11-9-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestBed.h"
#import "Reachability.h"

@implementation TestBed
@synthesize log;


-(void)doLog:(NSString *)formatstring,...
{
	va_list arglist;
	if (!formatstring) {
		return;
	}
	va_start(arglist,formatstring);
	NSString *outstring = [[[NSString alloc] initWithFormat:formatstring arguments:arglist] autorelease];
	va_end(arglist);
	[self.log appendString:outstring];
	[self.log appendString:@"\n"];
	textView.text = self.log;
}

-(void)action:(id)sender{
	self.log = [NSMutableString string];
	[self doLog:@"Host Name: %@",[Reachability hostname]];
	[self doLog:@"Local IP Addy:%@",[Reachability localIPAddress]];
	[self doLog:@"  Google IP Addy:%@",[Reachability getIPAddressForHost:@"www.google.com"]];
	[self doLog:@"  Amazon IP Addy:%@",[Reachability getIPAddressForHost:@"www.amazon.com"]];
	[self doLog:@"Local WiFi Addy:%@",[Reachability localWiFiIPAddress]];
	[self doLog:@"What is My IP:%@",[Reachability whatismyipdotcom]];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[log release];
    [super dealloc];
}


@end
