//
//  WKKTestModalViewController.m
//  UI_DEMOS
//
//  Created by wangkeke on 12-11-27.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "WKKTestModalViewController.h"

@interface WKKTestModalViewController ()

@end

@implementation WKKTestModalViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
