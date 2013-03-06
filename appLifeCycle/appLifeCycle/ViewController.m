//
//  ViewController.m
//  appLifeCycle
//
//  Created by keke Wang on 13-3-6.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

//1. 处理 不活动状态-活动状态 Label的动画暂停与开始
//2. 处理后台状态
//  2.1 进入后台删除一些资源，以避免被系统释放应用
//  2.2 进入后台保存状态
//  2.3 申请更多的后台时间

#import "ViewController.h"

@interface ViewController ()

@property (assign,nonatomic)BOOL isAnimate;

-(void)rotateLabelUp;
-(void)rotateLabelDown;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //注册接收应用活动与不活动两个通知
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(applicationWillResignActive)
                                                name:UIApplicationWillResignActiveNotification
                                              object:[UIApplication sharedApplication]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(applicationDidBecomeActive)
                                                name:UIApplicationDidBecomeActiveNotification
                                              object:[UIApplication sharedApplication]];
    //注册进入后台返回前台两个通知
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(applicationDidEnterBackground)
                                                name:UIApplicationDidEnterBackgroundNotification
                                              object:[UIApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(applicationWillEnterForeground)
                                                name:UIApplicationWillEnterForegroundNotification
                                              object:[UIApplication sharedApplication]];
    
    
    //添加一个标签到view中
    CGRect bounds = self.view.bounds;
    CGRect labelFrame = CGRectMake(bounds.origin.x, CGRectGetMidY(bounds)-50, bounds.size.width, 100);
    self.label = [[UILabel alloc]initWithFrame:labelFrame];
    self.label.text = @"Woooo";
    self.label.backgroundColor = [UIColor clearColor];

    
    //添加一个apple的图标
    CGRect appleFrame = CGRectMake(CGRectGetMidX(bounds)-65,CGRectGetMidY(bounds)/2, 130, 136);
    self.appleIconView = [[UIImageView alloc]initWithFrame:appleFrame];
    self.appleIconView.contentMode = UIViewContentModeScaleAspectFill;

    NSString *applePath = [[NSBundle mainBundle]pathForResource:@"apple" ofType:@".png"];
    self.appleIcon = [UIImage imageWithContentsOfFile:applePath];
    self.appleIconView.image = self.appleIcon;
    

    //添加一个分段开关
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"one",@"two",@"three",@"four"]];
    self.segmentedControl.frame = CGRectMake(bounds.origin.x+20,CGRectGetMinY(bounds)+20, bounds.size.width-40, 30);

    //读取保存的状态
    NSNumber *indexNumber=[[NSUserDefaults standardUserDefaults]objectForKey:@"SelectedIndex"];
    if (indexNumber) {
        NSInteger selectIndex = [indexNumber integerValue];
        self.segmentedControl.selectedSegmentIndex = selectIndex;
    }
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.appleIconView];
    [self.view addSubview:self.segmentedControl];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification
//程序变为不活动状态
-(void)applicationWillResignActive
{
    self.isAnimate = NO;
}

//程序变为活动状态
-(void)applicationDidBecomeActive
{
    self.isAnimate = YES;
    [self rotateLabelDown];
}

//程序进入后台
-(void)applicationDidEnterBackground
{
    UIApplication *app = [UIApplication sharedApplication];

    __block UIBackgroundTaskIdentifier taskId;
    taskId = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:taskId];
    }];
    
    if (taskId == UIBackgroundTaskInvalid) {
        NSLog(@"启动后台任务失败!");
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"程序得到%f秒的后台运行",app.backgroundTimeRemaining);
        
        //释放一些容易加载的资源
        self.appleIcon = nil;
        self.appleIconView.image = nil;
        
        //保存一些状态
        NSInteger selectedIndex = self.segmentedControl.selectedSegmentIndex;
        [[NSUserDefaults standardUserDefaults]setInteger:selectedIndex forKey:@"SelectedIndex"];

        //模拟一段长时间的任务
        [NSThread sleepForTimeInterval:20];
        NSLog(@"完成了一段长时间任务");
        [app endBackgroundTask:taskId];
    });
    
    
    
    }
//程序进入前台
-(void)applicationWillEnterForeground
{
    //恢复资源
    NSString *applePath = [[NSBundle mainBundle]pathForResource:@"apple" ofType:@".png"];
    self.appleIcon = [UIImage imageWithContentsOfFile:applePath];
    self.appleIconView.image = self.appleIcon;
}

#pragma mark - rotate

-(void)rotateLabelUp
{
    [UIView animateWithDuration:0.5 animations:^{
        self.label.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        if (self.isAnimate) {
            [self rotateLabelDown];
        }
    }];
}
-(void)rotateLabelDown
{
    [UIView animateWithDuration:0.5 animations:^{
        self.label.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        [self rotateLabelUp];
    }];
}

@end
