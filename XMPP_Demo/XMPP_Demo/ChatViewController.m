//
//  ChatViewController.m
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

@synthesize ChatTableView;
@synthesize messageField;
@synthesize chatWithUser;

#pragma mark - recive Delegate
-(void)newMessageReceived:(NSDictionary *)messageContent
{
    [messages addObject:messageContent];
    
    [self.ChatTableView reloadData];
}
///////
- (IBAction)CloseChat:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)SendMessage
{
    NSString *messageStr = self.messageField.text;
    if ([messageStr length]>0) {
        //使用XMPP发送消息
    
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:messageStr];
        
        NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
        [message addAttributeWithName:@"type" stringValue:@"chat"];
        [message addAttributeWithName:@"to" stringValue:chatWithUser];
        [message addChild:body];
        
        [self.xmppStream sendElement:message];
        
        //..
        
        
        self.messageField.text = @"";
    
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:messageStr forKey:@"msg"];
        [dic setObject:@"you" forKey:@"sender"];
        
        [messages addObject:dic];
        [self.ChatTableView reloadData];
        
    }
}
/*********************************************************************************/
#pragma mark - Table DataSource
/*********************************************************************************/
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageCellIdentifer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *info = (NSDictionary*)[messages objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [info objectForKey:@"msg"];
    cell.detailTextLabel.text = [info objectForKey:@"sender"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messages count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*********************************************************************************/
#pragma mark - LifeCycle
/*********************************************************************************/
-(id)initWithUser:(NSString *)userName
{
    if ((self = [super init])) {
        self.navigationItem.title = userName;
        self.chatWithUser = userName;
    }
    return self;    
}

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

    messages = [[NSMutableArray alloc]init];
    [self.messageField becomeFirstResponder];
    
    AppDelegate *del = [self appDelegate];
    del.messageDelegate = self;
}

- (void)viewDidUnload
{
    [self setMessageField:nil];
    [self setChatTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(AppDelegate *)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

-(XMPPStream*)xmppStream
{
    return [[self appDelegate]xmppStream];
}

@end
