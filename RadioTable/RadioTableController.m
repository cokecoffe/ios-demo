//
//  RadioTableController.m
//  Checkauto
//
//  Created by Wang keke on 12-6-21.
//  Copyright (c) 2012年 Uxin. All rights reserved.
//

#import "RadioTableController.h"

@interface RadioTableController ()

@end

@implementation RadioTableController
@synthesize TitleLabel;
@synthesize indicator;
@synthesize contentTable;
@synthesize isNeedIndex;
@synthesize delegate,dataSource;
@synthesize indexArray,contentArray;
@synthesize size;


-(void)startIndicator
{
    self.indicator.center = [self.view center];
    [self.indicator startAnimating];
}

-(void)stopIndicator
{
    [self.indicator stopAnimating];
}

-(void)requestData
{
    //状态指示器开始
    [self performSelectorOnMainThread:@selector(startIndicator) withObject:nil waitUntilDone:NO];
    
    //请求数据
    NSDictionary *dic = [self.dataSource provideData];//向数据源索要数据
    NSLog(@"%@",dic);
    
    self.TitleLabel.text = [dic objectForKey:@"title"]; //标题设置
    self.indexArray = [dic objectForKey:@"index"];//索引设置
    self.contentArray = [dic objectForKey:@"content"];//内容设置
    
    [[self.view.subviews objectAtIndex:0]reloadData];
    //取消状态指示
    [self performSelectorOnMainThread:@selector(stopIndicator) withObject:nil waitUntilDone:NO];
}


-(void)viewDidAppear:(BOOL)animated
{   
    [self performSelectorInBackground:@selector(requestData) withObject:nil]; 
}


-(void)viewDidDisappear:(BOOL)animated
{
    if (self.contentArray || self.indexArray) 
    {
        self.contentArray = nil;
        self.indexArray = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contentSizeForViewInPopover = self.size;//弹出框大小设置
    self.TitleLabel.frame = CGRectMake(0, 0, self.size.width, 40.0);//标题宽度适应弹出框宽度，高度暂定40.0
    
    //增加一个数据请求的指示框
    UIActivityIndicatorView *newindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];      
    self.indicator = newindicator;
    [newindicator release];
    
    [self.indicator setHidesWhenStopped:YES];
    [[self.view.subviews objectAtIndex:0] addSubview:self.indicator];  
    
}


-(void)configeWithDelegate:(id<SelectTableDelegate>)t_delegate 
                DataSource:(id<provideTableDataDelegate>)t_dataSource 
                      SIZE:(CGSize)t_size
                  HasIndex:(BOOL)t_isIndex
{
    self.delegate = t_delegate;
    self.dataSource = t_dataSource;
    self.size = t_size;
    self.isNeedIndex = t_isIndex;
}


- (void)viewDidUnload
{
    [self setContentTable:nil];
    [self setTitleLabel:nil];
    [self setIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

/*设置分区的标题*/
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (isNeedIndex)//带索引分区的 
    {
        return [self.indexArray objectAtIndex:section];
    }
    else
    {
        return nil;
    }
}

/*索引*/
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (isNeedIndex)//带索引分区的 
    {
        return self.indexArray;
    }
    else
    {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isNeedIndex)//带索引分区的 
    {
        return [self.indexArray count];
    }
    else//无索引，1个分区
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isNeedIndex) 
    {
        return [[self.contentArray objectAtIndex:section]count];
    }
    else 
    {
        return [self.contentArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    if (self.isNeedIndex == YES) 
    {
        cell.textLabel.text = [[[self.contentArray objectAtIndex:indexPath.section]allValues]objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [[[self.contentArray objectAtIndex:indexPath.row]allValues]objectAtIndex:0];
    }
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中后，将所选的项（Dictionary）返回值委托
    
    if (self.isNeedIndex == YES)//带索引的
    {
        id t_object = [[[self.contentArray objectAtIndex:indexPath.section]allValues]objectAtIndex:indexPath.row];
        NSString *t_key = [[[self.contentArray objectAtIndex:indexPath.section]allKeys]objectAtIndex:indexPath.row];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:t_object forKey:t_key];
        [delegate selectItem:dic Sender:self];
    }
    else//无索引的
    {
        [delegate selectItem:[self.contentArray objectAtIndex:indexPath.row]Sender:self];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消选择
}

- (void)dealloc
{
    [contentTable release];
    [TitleLabel release];
    [indicator release];
    [super dealloc];
}
@end
