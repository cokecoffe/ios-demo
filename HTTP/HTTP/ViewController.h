//
//  ViewController.h
//  HTTP
//
//  Created by 可可 王 on 12-6-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *statusLabel;
@property (retain, nonatomic) IBOutlet UITextField *UserNameField;
@property (retain, nonatomic) IBOutlet UITextField *PasswordField;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activity;
- (IBAction)Login:(id)sender;
@end
