//
//  TableViewViewController.m
//  TableView
//
//  Created by xwwang on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TableViewViewController.h"

@implementation TableViewViewController

@synthesize m_table;

- (void)dealloc
{
    [mutableArr release];
	[_refreshHeaderView release];
    [m_table release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    mutableArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int m = 0 ; m<20; m++) {
        UIImage  *img = [UIImage imageNamed:@"1.png"];
        UIImageView  *imgView = [[[UIImageView alloc]initWithImage:img]autorelease];
        [mutableArr addObject:imgView];
    }
    
    
    m_table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
    m_table.delegate = self;
    m_table.dataSource = self;
    [self.view addSubview:m_table];
    
    
    m_table.contentSize =CGSizeMake(320, 2000);
    NSLog(@"---->%f----->%f",m_table.contentSize.height,m_table.contentSize.width);
    
    
	_refreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:
						CGRectMake(0, m_table.contentSize.height, 320, 480)];
	_refreshHeaderView.delegate=self;
	[m_table addSubview:_refreshHeaderView];
	
	[_refreshHeaderView refreshLastUpdatedDate];
    

   
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma UITableViewDelegate-method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return [mutableArr count];
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    height+=100;
    
    return 100;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

       
   static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [m_table dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    for (UIView* subView  in [cell.contentView  subviews])
    {
        [subView removeFromSuperview] ;
    }
    
    NSInteger  num = [indexPath row];
    
	[cell.contentView addSubview:[mutableArr objectAtIndex:num]];
    
    return cell;
} 


-(void)requestImage{
	NSAutoreleasePool * pool=[[NSAutoreleasePool alloc] init];
	NSURL * url=[NSURL URLWithString:@"http://www.51xuexiw.com/1366x768/1366_768_nature_scene_wallpapers_01/wallpapers/1366x768/Free_High_resolution_nature_wallpapers_16.jpg"];
	NSURLRequest * request=[NSURLRequest requestWithURL:url];
	NSURLResponse * response;
	NSData * imgData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	UIImage * img=[UIImage imageWithData:imgData];
    UIImageView * imgView=[[[UIImageView alloc] initWithImage:img]autorelease];
    imgView.frame = CGRectMake(0, 0, 320, 90);
    [mutableArr addObject:imgView];
	
    
	[pool release];
	
	//回到主线程跟新界面
	[self performSelectorOnMainThread:@selector(dosomething) withObject:nil waitUntilDone:YES];
    
}

//此方法是开始读取数据
- (void)reloadTableViewDataSource{
	
	//should be calling your tableviews data source model to reload
	//put here just for demo
	_reloading = YES;
	NSLog(@"star");
	//打开线程，读取网络图片
	[NSThread detachNewThreadSelector:@selector(requestImage) toTarget:self withObject:nil];
    
}

-(void)dosomething
{
	
	int count=[mutableArr count];
	
	if(100*count>2000)
	{
		m_table.contentSize=CGSizeMake(320, 100*count);
		_refreshHeaderView.frame=CGRectMake(0, m_table.contentSize.height, 320, 480);
		
	}
	[self.m_table reloadData];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
}


//此方法是结束读取数据
- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:m_table];
	NSLog(@"end");
    
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:m_table];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:m_table];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


@end
