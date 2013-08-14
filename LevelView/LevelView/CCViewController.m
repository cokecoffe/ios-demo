//
//  CCViewController.m
//  LevelView
//
//  Created by keke Wang on 13-7-11.
//  Copyright (c) 2013年 keke Wang. All rights reserved.
//

#import "CCViewController.h"
#import "CCLevelView.h"

@interface CCViewController ()

@end

@implementation CCViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    CCLevelView *levelView = [[[NSBundle mainBundle] loadNibNamed:@"CCLevelView" owner:self options:nil]lastObject];
    
    NSLog(@"%f,%f,%f,%f",levelView.frame.origin.x,levelView.frame.origin.y,levelView.frame.size.width,levelView.frame.size.height);
    CGRect tmpFrame = [[UIScreen mainScreen] bounds];
    
    [levelView setCenter:CGPointMake(tmpFrame.size.width / 2, tmpFrame.size.height / 2)];
    
    [self.view addSubview:levelView];
    
    [levelView setLevel:4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
