//
//  AppDelegate.m
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "AppDelegate.h"
#import "BuddyListViewController.h"

@interface AppDelegate ()

-(void)setupStream;
-(void)getOnline;
-(void)goOffline;

@end

@implementation AppDelegate
@synthesize xmppStream;
@synthesize chatDelegate,messageDelegate;


/*********************************************************************************/
#pragma mark - XMPP Delegate
/*********************************************************************************/
/**
 * This method is called before the stream begins the connection process.
 *
 * If developing an iOS app that runs in the background, this may be a good place to indicate
 * that this is a task that needs to continue running in the background.
 **/
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    isOpen = YES;
    NSError *error = nil;
    
    NSLog(@"jid is %@@%@, password is %@", xmppStream.myJID.user, xmppStream.myJID.domain, password);
    
    if(![xmppStream authenticateWithPassword:password error:&error])
    {
        NSLog(@"验证失败%@",error);
    }
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
	if (!isOpen)
	{
        NSLog(@"Unable to connect to server. Check xmppStream.hostName");
	}
}

//验证失败后调用
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error{
    NSLog(@"没通过验证%@: %@", xmppStream.myJID.user, xmppStream.myJID.domain);
}

//验证成功后调用
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"验证通过");
    [self getOnline];
}

//接受到消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@"接收到消息message = %@", message);
    
    if ([message isChatMessageWithBody])
	{
        NSString *msg = [[message elementForName:@"body"]stringValue];
        NSString *from = [[message attributeForName:@"from"]stringValue];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:msg forKey:@"msg"];
        [dic setObject:from forKey:@"sender"];
        
        [messageDelegate newMessageReceived:dic];
    }
}

//接受到好友状态更新
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
  //  NSLog(@"presence = %@", presence);
    NSString *presenceType = [presence type];
//    NSString *myUserName = [[sender myJID]user];
    NSString *presenceFromUser = [[presence from]user];
    
    NSLog(@"Type:%@",presenceType);
    
    if ([presenceType isEqualToString:@"available"])
    {
        //上线会调用两次..
        [self.chatDelegate newBuddyOnline:[NSString stringWithFormat:@"%@@%@",presenceFromUser,@"oumatoimac.local"]];
    }else
    {
        [self.chatDelegate buddyWentOffline:[NSString stringWithFormat:@"%@@%@",presenceFromUser,@"oumatoimac.local"]];
    }
}

/*********************************************************************************/
#pragma mark - Connect/Disconnect
/*********************************************************************************/
-(void)setupStream{
    NSAssert(xmppStream == nil, @"Method setupStream invoked multiple times");
    xmppStream = [[XMPPStream alloc]init];
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
-(void)getOnline
{
    XMPPPresence *presence = [XMPPPresence presence];
    
    NSLog(@"Get Online stream:%@",[self xmppStream]);
    [[self xmppStream]sendElement:presence];
}
-(void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}

-(void)disconnect
{
    [self goOffline];
    [xmppStream disconnect];
}

-(BOOL)connect
{
    if (!xmppStream) {
        [self setupStream];
    }
        
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    
//    NSString *jabberID = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserID"];
//    NSString *jabeerpassword = [[NSUserDefaults standardUserDefaults]stringForKey:@"Password"];
  
     NSString *jabberID = @"jiaojiao@oumatoimac.local";
	 NSString *jabeerpassword  = @"12345";
    
    
    NSLog(@"用户名:%@",jabberID);
    NSLog(@"密码:%@",jabeerpassword);
    
    if (jabberID == nil || jabeerpassword == nil) {
        return NO;
    }
    
    [xmppStream setMyJID:[XMPPJID jidWithString:jabberID]];
    password = jabeerpassword;
    
    NSError *error = nil;
    if (![xmppStream connect:&error]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误"
                                                       message:[NSString stringWithFormat:@"连接服务器失败"]
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert show];
        return NO;
    }
    return YES;
}


/*********************************************************************************/
#pragma mark -
/*********************************************************************************/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    BuddyListViewController *buddyVC = [[BuddyListViewController alloc]initWithNibName:@"BuddyListViewController" bundle:nil];    
    [self.window setRootViewController:buddyVC];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
