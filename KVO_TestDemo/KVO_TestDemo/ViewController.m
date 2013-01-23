//
//  ViewController.m
//  KVO_TestDemo
//
//  Created by 勤 姚 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize dataModel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    DataModel *mod = [[DataModel alloc] init];
    self.dataModel = mod;
    [mod release];
    
    [self.dataModel setValue:@"10" forKey:@"needObserverValue"];
//    [self.dataModel addObserver:self forKeyPath:@"needObserverValue" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [self.dataModel addObserver:self forKeyPath:@"dataString" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
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

#pragma mark - ButtonClick Method
- (void)changeValueButtonClick:(id)sender
{
//    [self.dataModel setValue:[NSNumber numberWithInt:(arc4random()%20)] forKey:@"needObserverValue"];
//    self.dataModel.needObserverValue = arc4random()%20;
    self.dataModel.dataString = [NSString stringWithFormat:@"今天捡到%d块钱",arc4random()%20];
}

#pragma mark - KVO Delegate
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",keyPath);
    NSLog(@"%@ %@",object,self.dataModel);
    NSLog(@"%@",change);
    NSLog(@"%@",self.dataModel.dataString);
}

@end
