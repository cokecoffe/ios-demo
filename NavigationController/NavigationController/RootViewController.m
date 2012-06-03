//
//  RootViewController.m
//  NavigationController
//
//  Created by 可可 王 on 12-6-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController;
@synthesize titles;

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
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"第一行",@"第二行",nil];
    self.titles = array;
    [array release];
    
    //返回按钮，不设置的话,下一级将显示这一级的ViewController.title
    //设置方法:navigationItem.backBarButtonItem
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
    temporaryBarButtonItem.title = @"返回";  
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;  
    [temporaryBarButtonItem release];

   /*
    //右侧按钮,同上
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"设置"
                                                                       style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = settingsButton;
    [settingsButton release];
    */
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.titles = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault 
                                     reuseIdentifier:CellIdentifier]autorelease];
    }
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//扩展指示器
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
//    [[tableView cellForRowAtIndexPath:indexPath]setSelected:NO animated:YES];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailViewController.title = [self.titles objectAtIndex:indexPath.row];
#if 1
//中间变量
    detailViewController.detail_title = [self.titles objectAtIndex:indexPath.row];
    
    //右侧按钮,同上
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"设置"
                                                                       style:UIBarButtonItemStylePlain target:self action:nil];
    detailViewController.navigationItem.rightBarButtonItem = settingsButton;
    [settingsButton release];
#else
//直接赋值，这样的话ViewTitle还没有初始化，所以无法将值传递给下一级
    detailViewController.ViewTitle.text = [self.titles objectAtIndex:indexPath.row];
#endif
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
     
}

@end
