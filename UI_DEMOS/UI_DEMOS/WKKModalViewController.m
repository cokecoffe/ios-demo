//
//  WKKModelViewController.m
//  UI_DEMOS
//
//  Created by wangkeke on 12-11-27.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "WKKModalViewController.h"
#import "WKKTestModalViewController.h"

@interface WKKModalViewController ()

@property (assign,nonatomic) NSInteger traSytle;

@end

@implementation WKKModalViewController


- (IBAction)transitionStyleSelect:(UISegmentedControl *)sender {
    self.traSytle = sender.selectedSegmentIndex;
}

- (IBAction)presentModelView:(UIButton *)sender {
    
    UIModalPresentationStyle preStyle;//弹出风格
    
    switch (sender.tag) {
        case 0:
            preStyle = UIModalPresentationFullScreen;//iphone Touch只支持此项目
            break;
        case 1:
            preStyle = UIModalPresentationPageSheet;
            break;
        case 2:
            preStyle = UIModalPresentationFormSheet;
            break;
        case 3:
            preStyle = UIModalPresentationCurrentContext;
            break;            
        default:
            preStyle = UIModalPresentationFullScreen;
            break;
    }
    
    WKKTestModalViewController *testVC = [[WKKTestModalViewController alloc]initWithNibName:@"WKKTestModalViewController" bundle:nil];
    
    testVC.modalPresentationStyle = preStyle;
    testVC.modalTransitionStyle = self.traSytle;
    
    [self presentViewController:testVC animated:YES completion:^{
        
    }];
    
    [testVC release];
    
}










#pragma mark - life cycle


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

@end
