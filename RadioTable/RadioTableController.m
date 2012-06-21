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

@synthesize contentTable;
@synthesize isNeedIndex;
@synthesize delegate,dataSource;
@synthesize indexArray,contentArray;
@synthesize size;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dic = [self.dataSource provideData];//向数据源索要数据
    
    self.TitleLabel.text = [dic objectForKey:@"title"]; //标题设置
    self.indexArray = [dic objectForKey:@"index"];//索引设置
    self.contentArray = [dic objectForKey:@"content"];//内容设置
    self.contentSizeForViewInPopover = self.size;//弹出框大小设置
    self.TitleLabel.frame = CGRectMake(0, 0, self.size.width, 40.0);//标题宽度适应弹出框宽度，高度暂定40.0
    
}

- (void)viewDidUnload
{
    [self setContentTable:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

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
        [delegate selectItem:dic];
    }
    else//无索引的
    {
        [delegate selectItem:[self.contentArray objectAtIndex:indexPath.row]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消选择
}

- (void)dealloc {
    [contentTable release];
    [TitleLabel release];
    [super dealloc];
}
@end
