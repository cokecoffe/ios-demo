//
//  WKKRootTableViewController.m
//  UI_DEMOS
//
//  Created by wangkeke on 12-11-27.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "WKKRootTableViewController.h"

@interface WKKRootTableViewController ()

@property (retain,nonatomic) NSArray *contents;

@end


@implementation WKKRootTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"IOS Demos by Wkk";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TableContent" ofType:@"plist"];
    self.contents = [NSArray arrayWithContentsOfFile:filePath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.contents objectAtIndex:section]objectForKey:@"Name"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.contents objectAtIndex:section]objectForKey:@"items"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[[[self.contents objectAtIndex:indexPath.section]objectForKey:@"items"]objectAtIndex:indexPath.row]objectForKey:@"demoName"];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *className = [[[[self.contents objectAtIndex:indexPath.section]objectForKey:@"items"]objectAtIndex:indexPath.row]objectForKey:@"className"];

    UIViewController *vc = [[NSClassFromString(className) alloc] initWithNibName:className bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];

}

@end
