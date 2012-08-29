//
//  ViewController.m
//  ButtonDemo
//
//  Created by keke Wang on 12-8-22.
//  Copyright (c) 2012年 keke Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:CGRectMake(0, 0, 120.0, 18.0)];
    
    bt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //title
    [bt setTitle:@"一二三/六七八" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  //  bt.titleLabel.textAlignment = UITextAlignmentLeft;
    [bt.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [bt setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 10.0,0.0,0.0)];
    
    //picture
    [bt setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    
    
    [self.view addSubview:bt];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
