//
//  TemperatureViewController.m
//  with_IB
//
//  Created by 可可 王 on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TemperatureViewController.h"

@interface TemperatureViewController ()

@end

@implementation TemperatureViewController

-(void)convert:(id)sender
{
    float invalue = [[field1 text]floatValue];
    float outvalue = (invalue-32.0f)*5.0f/9.0f;
    
    [field2 setText:[NSString stringWithFormat:@"%3.2f",outvalue]];
    [field1 resignFirstResponder];
}

-(void)loadView
{
    //创建主视图
    UIView *contentView = [[UIView alloc]initWithFrame:
                        [[UIScreen mainScreen]applicationFrame]];
    
    self.view = contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView release];
    
    //添加背景
    UIImageView *iv = [[UIImageView alloc]initWithImage:
                    [UIImage imageNamed:@"cover320x416.png"]];
    [self.view addSubview:iv];
    iv.userInteractionEnabled = YES;
  
    //两个文本框
    field1 = [[UITextField alloc]initWithFrame:CGRectMake(185.0, 31.0, 97.0, 31.0)];
    field1.borderStyle = UITextBorderStyleRoundedRect;
    field1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    field1.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    
    field2 = [[UITextField alloc]initWithFrame:CGRectMake(185.0, 97.0, 97.0, 31.0)];
    field2.borderStyle = UITextBorderStyleRoundedRect;
    field2.enabled = NO;
    field2.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //两个标签
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(95.0, 34.0, 82.0, 21.0)];
    label1.text = @"华氏";
    label1.textAlignment = UITextAlignmentLeft;
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(121.0, 102.0, 56.0, 21.0)];
    label2.text = @"摄氏";
    label2.textAlignment = UITextAlignmentLeft;    
    
  
    //将文本框与按钮加入iv中
    [iv addSubview:field1];
    [iv addSubview:field2];
    [iv addSubview:label1];
    [iv addSubview:label2];
    
    //引用计数减1
    [field1 release];
    [field2 release];
    [label1 release];
    [label2 release];
    [iv release];
    
    self.title = @"温度转换器";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"转换" style:UIBarButtonItemStylePlain target:self action:@selector(convert:)]autorelease];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.2f green:0.19f blue:0.61f alpha:1.0f];
    
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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
