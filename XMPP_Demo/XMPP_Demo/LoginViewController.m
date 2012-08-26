//
//  LoginViewController.m
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize UserNameField;
@synthesize PasswordFiled;

/*********************************************************************************/
#pragma mark - Actions
/*********************************************************************************/
- (IBAction)Login:(id)sender {

    //保存用户名、密码到 配置文件中
    [[NSUserDefaults standardUserDefaults] setObject:self.UserNameField.text forKey:@"UserID"];
    [[NSUserDefaults standardUserDefaults] setObject:self.PasswordFiled.text forKey:@"Password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)Logout:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

/*********************************************************************************/
#pragma mark - LifeCycle
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
}

- (void)viewDidUnload
{
    [self setUserNameField:nil];
    [self setPasswordFiled:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
