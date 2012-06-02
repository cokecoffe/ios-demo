//
//  DownLoad.m
//  UseNetWork
//
//  Created by  vistech on 11-10-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DownLoad.h"
#import "Reachability.h"

#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
	//3MB
#define SAMLL_URL @"http://www.archive.org/download/Drive-inSaveFreeTv/Drive-in--SaveFreeTv_512kb.mp4"
	//23MB
#define BIG_URL @"http://www.archive.org/download/BettyBoopCartoons/Betty_Boop_More_Pep_1936_512kb.mp4"
	//wrong url
#define FAKE_URL @"http://www.idontbelievethisisavalidurlforthisexample.com"
#define DEST_PATH [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

@implementation DownLoad
@synthesize log;
@synthesize textView;
@synthesize savepath;

-(void)myMovieFinishedCallback:(NSNotification *)aNotification{
	MPMoviePlayerController *theMovie = [aNotification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
	[theMovie release];
}

-(void)startPlayback:(id)sender{
	MPMoviePlayerController* theMovie = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:self.savepath]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
	[theMovie play];
	
}
//解决多参数问题
-(void)doLog:(NSString *)formatstring,...{
	va_list arglist;
	if (!formatstring) {
		return;
	}
	
	va_start(arglist,formatstring);//第一个可选参数地址
	NSString *outString = [[[NSString alloc] initWithFormat:formatstring arguments:arglist] autorelease];
	va_end(arglist);//将指针无效化
	[self.log appendString:outString];
	[self.log appendString:@"\n"];
	[textView performSelectorOnMainThread:@selector(setText:) withObject:self.log waitUntilDone:NO];
}

-(void)finishedGettingData{
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Get Data" style:UIBarButtonItemStylePlain target:self action:@selector(action:)];
if ([[NSFileManager defaultManager] fileExistsAtPath:self.savepath]) {
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Play" style:UIBarButtonItemStylePlain target:self action:@selector(startPlayback:)];
}
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[(UISegmentedControl *)self.navigationItem.titleView setEnabled:YES];
}

-(void)getData:(NSNumber *)which{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	self.log = [NSMutableString string];
	[self doLog:@"Downloading data now...\n"];
	NSDate *date = [NSDate date];
	NSLog(@"%@",date);
	
	
	NSArray *urlArray = [NSArray arrayWithObjects:SAMLL_URL,BIG_URL,FAKE_URL,nil];
	NSURL *url = [NSURL URLWithString:[urlArray objectAtIndex:[which intValue]]];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSURLResponse *response;
	NSError *error;
	NSData *result = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
	[self doLog:@"Respone expects %d bytes:",[response expectedContentLength]];
	[self doLog:@"Respone suggested file name:",[response suggestedFilename]];
	if ([response suggestedFilename]) {
		self.savepath = [DEST_PATH stringByAppendingString:[response suggestedFilename]];
	}
	
	if (!result) {
		[self doLog:@"Error downloading data:%@",[error localizedDescription]];
	}
	else if([response expectedContentLength] < 0){
		[self doLog:@"Error with download. Carrier redirect?"];
	}else {
		[self doLog:@"Download succeeded."];
		[self doLog:@"Read %d bytes",result.length];
		[self doLog:@"Elapsed time: %0.2f seconds.",-1 * [date timeIntervalSinceNow]];
		[result writeToFile:self.savepath atomically:YES];
		[self doLog:@"Data written to file : %@",self.savepath];
	}
	
	[self performSelectorOnMainThread:@selector(finishedGettingData) withObject:nil waitUntilDone:NO];
	[pool release];

}

-(void)action:(UIBarButtonItem *)bbi{
	if ([[Reachability reachabilityWithHostName:@"www.baidu.com"] currentReachabilityStatus] == NotReachable) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Woring" message:@"NO Net Work" delegate:self cancelButtonTitle:@"OK,I Know" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}else {
		NSNumber *which = [NSNumber numberWithInt:[(UISegmentedControl *)self.navigationItem.titleView selectedSegmentIndex]];
		self.navigationItem.rightBarButtonItem = nil;
		[(UISegmentedControl *)self.navigationItem.titleView setEnabled:NO];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[NSThread detachNewThreadSelector:@selector(getData:) toTarget:self withObject:which];
	}
}
	
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
	self.navigationController.navigationBar.tintColor = COOKBOOK_PURPLE_COLOR;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Get Data" style:UIBarButtonItemStylePlain target:self action:@selector(action:)] autorelease];
    UISegmentedControl *seg = [[[UISegmentedControl alloc] initWithItems:[@"Short Long Wrong" componentsSeparatedByString:@" "]] autorelease];
	seg.selectedSegmentIndex = 0;
	seg.segmentedControlStyle = UISegmentedControlStyleBar;
	self.navigationItem.titleView = seg;
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
	[textView release];
	[savePath release];
    [super dealloc];
}


@end
