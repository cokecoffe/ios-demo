//
//  Authentication.m
//  UseNetWork
//
//  Created by  vistech on 11-10-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Authentication.h"

#define DEST_PATH [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

@implementation Authentication
@synthesize log;
@synthesize savePath;
@synthesize textView;
@synthesize progress;
@synthesize unauthorized,authorized;

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
	//下载失败调用
-(void)dataDownloadFailed:(NSString *)reason{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	if (reason) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong" message:@"Download Failed" delegate:self cancelButtonTitle:@"OK,I Know" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}
    //接收数据
-(void)didReceiveData:(NSData *)theData{
	NSString *results = [[[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding] autorelease];
	[theData release];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	self.textView.text = results;
}
    //接收文件名
-(void)didReceiveFilename:(NSString *)aName{
	self.savePath = [DEST_PATH stringByAppendingString:aName];
}

-(IBAction)unauthorized:(id)sender{
	self.log = [NSMutableString string];
	self.textView.text = @"Starting Download...";
		//准备下载
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	NSString *urlString = @"http://ericasadun.com/Private/";
	[DownLoadHelper sharedInstance].delegate = self;
	[DownLoadHelper sharedInstance].username = nil;
	[DownLoadHelper sharedInstance].userpassword = nil;
	[DownLoadHelper download:urlString];
}

-(IBAction)authorized:(id)sender{
	self.log = [NSMutableString string];
	self.textView.text = @"Starting Download...";
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	NSString *urlString = @"http://ericasadun.com/Private/";
	[DownLoadHelper sharedInstance].username = @"PrivateAccess";
	[DownLoadHelper sharedInstance].userpassword = @"tuR7!mZ#eh";
	[DownLoadHelper sharedInstance].delegate = self;
	[DownLoadHelper download:urlString];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.navigationController.navigationBar.tintColor = COOKBOOK_PURPLE_COLOR;
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
	[savePath release];
	[textView release];
	[progress release];
	[unauthorized release];
	[authorized release];
    [super dealloc];
}

@end
