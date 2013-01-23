//
//  ViewController.h
//  KVO_TestDemo
//
//  Created by 勤 姚 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataModel;

@interface ViewController : UIViewController

@property (nonatomic,retain)DataModel *dataModel;

- (IBAction)changeValueButtonClick:(id)sender;
@end
