//
//  checkWebSitReachable.m
//  UseNetWork
//
//  Created by  vistech on 11-9-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "checkWebSitReachable.h"


@implementation checkWebSitReachable
@synthesize btn;
@synthesize log;
@synthesize textView;
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
- (void)viewDidLoad {
	[self.btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
	[super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)doLog:(NSString *)formatstring,...{
	va_list arglist;
	if (!formatstring) {
		return;
	}
	va_start(arglist, formatstring);
	NSString *outstring = [[[NSString alloc] initWithFormat:formatstring arguments:arglist] autorelease];
	va_end(arglist);
	[self.log appendString:outstring];
	[self.log appendString:@"\n"];
	self.textView.text = self.log;
    
}
-(void)action:(UIButton *)button{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	self.log = [NSMutableString string];
	[self doLog:[NSString stringWithFormat:@"site:www.google.com,%@",([Reachability hostAvailable:@"www.google.com"] ? @"available":@"not available")]];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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
	[textView release];
	[btn release];
	[log release];
    [super dealloc];
}


@end
