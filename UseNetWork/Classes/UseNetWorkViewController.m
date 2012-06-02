//
//  UseNetWorkViewController.m
//  UseNetWork
//
//  Created by  vistech on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UseNetWorkViewController.h"

@implementation UseNetWorkViewController
@synthesize netWorks;


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [netWorks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *indentify = @"indentify";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
									  reuseIdentifier:indentify] autorelease];
	}
	cell.textLabel.text = [netWorks objectAtIndex:indexPath.row];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UIViewController *viewController = [views objectForKey:[netWorks objectAtIndex:indexPath.row]];
	[delegate.navigation pushViewController:viewController animated:YES];
}

-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
	return UITableViewCellStyleValue1;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	delegate =[[UIApplication sharedApplication] delegate];
	testConnect = [[TestNetWorkConnection alloc] init];
	testIP = [[TestBed alloc] init];
	webSitReachale = [[checkWebSitReachable alloc] init];
	download = [[DownLoad alloc] init];
	asynchronousDown = [[AsynchronousDownLoad alloc] init];
	authentication = [[Authentication alloc] init];
	useXMLParser = [[UseXMLParser alloc] initWithURL:[NSString stringWithString:@"http://newsvote.bbc.co.uk/rss/newsonline_uk_edition/sci/tech/rss.xml"]];
	parserjson = [[ParserJSON alloc] init];
	
	netWorks = [[NSArray alloc] initWithObjects:@"测试网络链接",
												@"获取IP和主机信息",
												@"检查站点是否可达",
												@"同步下载",
												@"异步下载",
												@"身份验证",
												@"XML解析",
												@"JSON解析",nil];
	
	views = [[NSMutableDictionary alloc] initWithObjectsAndKeys:testConnect,@"测试网络链接",
																testIP,@"获取IP和主机信息",
																webSitReachale,@"检查站点是否可达",
																download,@"同步下载",
																asynchronousDown,@"异步下载",
																authentication,@"身份验证",
																useXMLParser,@"XML解析",
																parserjson,@"JSON解析",nil];
    [super viewDidLoad];
	[testIP release];
	[download release];
	[asynchronousDown release];
	[authentication release];
	[useXMLParser release];
	[parserjson release];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[netWorks release];
	[delegate release];
	[testConnect release];
    [super dealloc];
}

@end
