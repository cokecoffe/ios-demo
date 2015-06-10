//
//  ViewController.m
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "BuddyListViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ChatViewController.h"

@interface BuddyListViewController ()

@end

@implementation BuddyListViewController


-(AppDelegate *)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

-(XMPPStream*)xmppStream
{
    return [[self appDelegate]xmppStream];
}


/*********************************************************************************/
#pragma mark - ChatDelegate
/*********************************************************************************/
-(void)newBuddyOnline:(NSString *)buddyName
{
    if ([onlineBuddies containsObject:buddyName]) {
        return;
    }
    [onlineBuddies addObject:buddyName];
    [buddyTableView reloadData];
}

-(void)buddyWentOffline:(NSString *)buddyName
{
    [onlineBuddies removeObject:buddyName];
    [buddyTableView reloadData];
}


/*********************************************************************************/
#pragma mark - Actions
/*********************************************************************************/

- (IBAction)showLogin:(id)sender {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self presentModalViewController:loginVC animated:YES];
}


/*********************************************************************************/
#pragma mark - TableDelegate
/*********************************************************************************/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中某个好友，开始对话
    NSString *userName = (NSString *)[onlineBuddies objectAtIndex:indexPath.row];
    NSLog(@"开始与%@对话",userName);
    ChatViewController *chatVC = [[ChatViewController alloc]initWithUser:userName];
    [self presentModalViewController:chatVC animated:YES];
}


/*********************************************************************************/
#pragma mark - TableDataSource
/*********************************************************************************/
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BuddyCell";

    //创建Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //配置Cell
    cell.textLabel.text = (NSString*)[onlineBuddies objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [onlineBuddies count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*********************************************************************************/
#pragma mark - LifyCycle
/*********************************************************************************/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    onlineBuddies = [[NSMutableArray alloc]init];//创建好友列表
    [onlineBuddies addObject:@"hbsxd002@openfire.c56shequ.com"];
    
    AppDelegate *del = [self appDelegate];
    [del setChatDelegate:self];
}

- (void)viewDidUnload
{
    buddyTableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
    NSString *login = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserID"];
    if (!login)//如果没有输入过密码，那么进入登陆界面
    {
        [self showLogin:nil];
    }else
    {
        if ([[self appDelegate]connect])
        {
            NSLog(@"显示 朋友 列表");
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
