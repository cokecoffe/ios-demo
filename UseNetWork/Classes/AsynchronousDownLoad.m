//
//  AsynchronousDownLoad.m
//  UseNetWork
//
//  Created by  vistech on 11-10-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsynchronousDownLoad.h"
#import "Reachability.h"

#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define SAMLL_URL @"http://www.archive.org/download/Drive-inSaveFreeTv/Drive-in--SaveFreeTv_512kb.mp4"
#define BIG_URL @"http://wwww.archive.org/download/BettyBoopCartoons/Betty_Boop_More_Pep_1936_512kb.mp4"
#define FAKE_URL @"http://wwww.idontbelievethisisavalidurlforthisexample.com"
#define DEST_PATH [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

@implementation AsynchronousDownLoad
@synthesize log;
@synthesize textView;
@synthesize savePath;
@synthesize progress;
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
-(void)startPlayback:(id)sender{
	MPMoviePlayerController *theMovie = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:self.savePath]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
	[theMovie play];
}
-(void)myMovieFinishedCallback:(NSNotification *)aNotification{
	MPMoviePlayerController *theMovie = [aNotification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
	[theMovie release];
}

-(void)restoreGUI{
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Get Data" style:UIBarButtonItemStylePlain target:self action:@selector(action:)];
	if ([[NSFileManager defaultManager] fileExistsAtPath:DEST_PATH]) 
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Play" style:UIBarButtonItemStylePlain target:self action:@selector(startPlayback:)];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[(UISegmentedControl *)self.navigationItem.titleView setEnabled:YES];
	[progress setHidden:YES];
}

-(void)doLog:(NSString *)formString,...{
	va_list arglist;
	if (!formString) {
		return;
	}
	va_start(arglist,formString);
	NSString *outString = [[[NSString alloc] initWithFormat:formString arguments:arglist] autorelease];
	va_end(arglist);
	
	[self.log appendString:outString];
	[self.log appendString:@"\n"];
	[self.textView performSelectorOnMainThread:@selector(setText:) withObject:log waitUntilDone:NO];
}


	//下载进度
-(void) dataDownloadAtPercent:(NSNumber *)aPercent{
	[progress setHidden:NO];
	[progress setProgress:[aPercent floatValue]];
}
	//下载失败
-(void)dataDownloadFailed:(NSString *)reason{
	[self restoreGUI];
	if (reason) {
		[self doLog:@"Download failed :%@",reason];
	}
}
	//下载文件的文件名
-(void)didReceiveFilename:(NSString *)aName{
	self.savePath = [DEST_PATH stringByAppendingString:aName];
}
	//接收下载数据
-(void)didReceiveData:(NSData *)theData{
	if (![theData writeToFile:self.savePath atomically:YES]) {
		[self doLog:@"Error writing data to file"];
	}
	[theData release];
	[self restoreGUI];
	[self doLog:@"Download Successed"];
}

-(void)action:(UIBarButtonItem *)bbi{
	//检查网络
	if ([[Reachability reachabilityWithHostName:@"wwww.baidu.com"] currentReachabilityStatus] == NotReachable) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong" message:@"NO Work" delegate:self cancelButtonTitle:@"YES, I Konw" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	self.progress.hidden = NO;
	self.log = [NSMutableString string];
	[self doLog:@"Starting Download..."];
	
	int witch = [(UISegmentedControl *)self.navigationItem.titleView selectedSegmentIndex];
	NSArray *urlArray = [NSArray arrayWithObjects:SAMLL_URL,BIG_URL,FAKE_URL,nil];
	NSString *urlString = [urlArray objectAtIndex:witch];
	
	self.navigationItem.rightBarButtonItem = nil;
	self.navigationItem.leftBarButtonItem = nil;
	[(UISegmentedControl *)self.navigationItem.titleView setEnabled:NO];
		//开启网络活动标识之后，会调用dataload的几个方法，（个人理解）
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	[DownLoadHelper sharedInstance].delegate = self;
	[DownLoadHelper download:urlString];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.navigationController.navigationBar.tintColor = COOKBOOK_PURPLE_COLOR;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Get Data" style:UIBarButtonItemStylePlain target:self action:@selector(action:)];
	
	UISegmentedControl *segment = [[[UISegmentedControl alloc] initWithItems:[@"Short Long Wrong" componentsSeparatedByString:@" "]] autorelease];
	segment.selectedSegmentIndex = 0;
	segment.segmentedControlStyle = UISegmentedControlStyleBar;
	
	self.navigationItem.titleView = segment;
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
	[progress release];
	[savePath release];
    [super dealloc];
}


@end
