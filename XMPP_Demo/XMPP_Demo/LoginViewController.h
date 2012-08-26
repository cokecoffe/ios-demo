//
//  LoginViewController.h
//  XMPP_Demo
//
//  Created by wangkeke on 12-8-19.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{

}

@property (weak, nonatomic) IBOutlet UITextField *UserNameField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordFiled;

- (IBAction)Login:(id)sender;
- (IBAction)Logout:(id)sender;

@end
